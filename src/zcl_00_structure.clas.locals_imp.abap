*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lcl_connection DEFINITION.

  PUBLIC SECTION.
    CLASS-DATA conn_counter TYPE i.

    METHODS constructor
      IMPORTING
        i_connection_id TYPE /dmo/connection_id
        i_carrier_id    TYPE /dmo/carrier_id
      RAISING
        cx_ABAP_INVALID_VALUE .

    METHODS get_output
      RETURNING
        VALUE(r_output) TYPE string_table.

  PROTECTED SECTION.

  PRIVATE SECTION.

    TYPES: BEGIN OF st_details,
             DepartureAirport   TYPE /dmo/airport_from_id,
             DestinationAirport TYPE   /dmo/airport_to_id,
             AirlineName        TYPE   /dmo/carrier_name,
           END OF st_details.

    DATA carrier_id    TYPE /dmo/carrier_id.
    DATA connection_id TYPE /dmo/connection_id.

    DATA details TYPE st_details.


  ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.

  METHOD constructor.

    " ensure non-initial input
    IF i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

    " check existence and read additional data
    SELECT SINGLE
      FROM /DMO/I_Connection
    FIELDS DepartureAirport, DestinationAirport, \_Airline-Name as AirlineName
     WHERE AirlineID    = @i_carrier_id
       AND ConnectionID = @i_connection_id
      INTO CORRESPONDING FIELDS OF @details.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

    me->connection_id = i_connection_id.
    me->carrier_id    = i_carrier_id.

    conn_counter = conn_counter + 1.

  ENDMETHOD.

  METHOD get_output.

*    APPEND |--------------------------------|             TO r_output.
*    APPEND |Carrier:     { carrier_id } { carrier_name }| TO r_output.
*    APPEND |Connection:  { connection_id   }|             TO r_output.
*    APPEND |Departure:   { airport_from_id }|             TO r_output.
*    APPEND |Destination: { airport_to_id   }|             TO r_output.

    APPEND |--------------------------------|                    TO r_output.
    APPEND |Carrier:     { carrier_id } { details-airlinename }| TO r_output.
    APPEND |Connection:  { connection_id   }|                    TO r_output.
    APPEND |Departure:   { details-departureairport     }|       TO r_output.
    APPEND |Destination: { details-destinationairport   }|       TO r_output.

  ENDMETHOD.

ENDCLASS.
