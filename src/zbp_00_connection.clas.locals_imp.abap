CLASS lhc_connection DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR Connection
        RESULT result,
      CheckSemanticKey FOR VALIDATE ON SAVE
        IMPORTING keys FOR Connection~CheckSemanticKey,
      CheckCerrierID FOR VALIDATE ON SAVE
        IMPORTING keys FOR Connection~CheckCerrierID,
      CheckOriginDestination FOR VALIDATE ON SAVE
        IMPORTING keys FOR Connection~CheckOriginDestination,
      GetCities FOR DETERMINE ON SAVE
        IMPORTING keys FOR Connection~GetCities.
ENDCLASS.

CLASS lhc_connection IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD CheckSemanticKey.
    READ ENTITIES OF z00_r_connection IN LOCAL MODE
           ENTITY Connection
           FIELDS ( CarrierID ConnectionID )
             WITH CORRESPONDING #( keys )
           RESULT DATA(connections).


    LOOP AT connections INTO DATA(connection).
      SELECT FROM z00_aconn
            FIELDS uuid
             WHERE carrier_id    = @connection-CarrierID
               AND connection_id = @connection-ConnectionID
               AND uuid          <> @connection-uuid
       UNION
       SELECT FROM z00dconn
            FIELDS uuid
             WHERE carrierid     = @connection-CarrierID
               AND connectionid  = @connection-ConnectionID
               AND uuid          <> @connection-uuid

        INTO TABLE @DATA(check_result).


      IF check_result IS NOT INITIAL.

        DATA(message) = me->new_message(
                          id       = 'ZS4D400'
                          number   = '001'
                          severity = ms-error
                          v1       = connection-CarrierID
                          v2       = connection-ConnectionID
                        ).


        DATA reported_record LIKE LINE OF reported-connection.

        reported_record-%tky = connection-%tky.
        reported_record-%msg = message.
        reported_record-%element-CarrierID    = if_abap_behv=>mk-on.
        reported_record-%element-ConnectionID = if_abap_behv=>mk-on.

        APPEND reported_record TO reported-connection.


        DATA failed_record LIKE LINE OF failed-connection.

        failed_record-%tky = connection-%tky.
        APPEND failed_record TO failed-connection.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD CheckCerrierID.

    READ ENTITIES OF z00_r_connection IN LOCAL MODE
           ENTITY Connection
           FIELDS (  CarrierID )
             WITH CORRESPONDING #(  keys )
           RESULT DATA(connections).


    LOOP AT connections INTO DATA(connection).

      SELECT SINGLE
        FROM /DMO/I_Carrier
      FIELDS @abap_true
       WHERE airlineid = @connection-CarrierID
       INTO @DATA(exists).



      IF exists = abap_false.

        DATA(message) = me->new_message(
                            id       = 'ZS4D400'
                            number   = '002'
                            severity =  ms-error
                            v1       = connection-CarrierID
                          ) .

        DATA reported_record LIKE LINE OF reported-connection.

        reported_record-%tky = connection-%tky.
        reported_record-%msg = message.
        reported_record-%element-carrierid = if_abap_behv=>mk-on.

        APPEND reported_record TO reported-connection.


        DATA failed_record LIKE LINE OF failed-connection.

        failed_record-%tky = connection-%tky.
        APPEND failed_Record TO failed-connection.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD CheckOriginDestination.

    READ ENTITIES OF z00_r_Connection IN LOCAL MODE
           ENTITY Connection
           FIELDS ( AirportFromID AirportToID )
             WITH CORRESPONDING #(  keys )
           RESULT DATA(connections).


    LOOP AT connections INTO DATA(connection).
      IF connection-AirportFromID = connection-AirportToID.
        DATA(message) = me->new_message(
                          id       = 'ZS4D400'
                          number   = '003'
                          severity = ms-error
                       ).

        DATA reported_record LIKE LINE OF reported-connection.

        reported_record-%tky =  connection-%tky.
        reported_record-%msg = message.
        reported_record-%element-AirportFromID = if_abap_behv=>mk-on.
        reported_record-%element-AirportToID   = if_abap_behv=>mk-on.

        APPEND reported_record TO reported-connection.

        DATA failed_record LIKE LINE OF failed-connection.

        failed_record-%tky = connection-%tky.
        APPEND failed_record TO failed-connection.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD GetCities.

    READ ENTITIES OF z00_r_connection IN LOCAL MODE
           ENTITY Connection
           FIELDS ( AirportFromID AirportToID )
             WITH CORRESPONDING #( keys )
           RESULT DATA(connections).


    LOOP AT connections INTO DATA(connection).

      SELECT SINGLE
        FROM /DMO/I_Airport
      FIELDS city, CountryCode
       WHERE AirportID = @connection-AirportFromID
        INTO ( @connection-CityFrom, @connection-CountryTo ).

      SELECT SINGLE
        FROM /DMO/I_Airport
      FIELDS city, CountryCode
       WHERE AirportID = @connection-AirportToID
        INTO ( @connection-CityTo, @connection-CountryTo ).

      MODIFY connections FROM connection.

    ENDLOOP.

    DATA connections_upd TYPE TABLE FOR UPDATE z00_r_connection.
    connections_upd = CORRESPONDING #( connections ).

    MODIFY ENTITIES OF z00_r_connection IN LOCAL MODE
             ENTITY Connection
             UPDATE
             FIELDS ( CityFrom CountryFrom CityTo CountryTo )
               WITH connections_upd
           REPORTED DATA(reported_records).

    reported-connection = CORRESPONDING #( reported_records-connection ).

  ENDMETHOD.

ENDCLASS.
