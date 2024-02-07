*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lcl_connection DEFINITION CREATE PRIVATE.
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        airlineid        TYPE /dmo/carrier_id
        connectionnumber TYPE /dmo/connection_id
        fromAirport      TYPE /dmo/airport_from_id
        toAirport        TYPE /dmo/airport_to_id.


    CLASS-METHODS get_connection IMPORTING airlineId            TYPE /dmo/carrier_id
                                           connectionNumber     TYPE /dmo/connection_id
                                 RETURNING VALUE(ro_connection) TYPE REF TO lcl_Connection.

  PRIVATE SECTION.


    TYPES: BEGIN OF ts_instance,
             airlineId        TYPE /dmo/carrier_id,
             connectionNumber TYPE /dmo/connection_id,
             object           TYPE REF TO lcl_connection,
           END OF ts_instance,
           tt_instances TYPE HASHED TABLE OF ts_instance
                          WITH UNIQUE KEY airlineId ConnectionNumber.


    DATA AirlineId TYPE /dmo/carrier_id.
    DATA ConnectionNumber TYPE /dmo/connection_id.
    DATA fromAirport TYPE /dmo/airport_from_id.
    DATA toAirport TYPE /dmo/airport_to_id.
    CLASS-DATA connections TYPE tt_instances.
ENDCLASS.


CLASS lcl_connection IMPLEMENTATION.


  METHOD constructor.


    me->airlineid = airlineid.
    me->connectionnumber = connectionnumber.
    me->fromAirport = fromAirport.
    me->toAirport = toAirport.


  ENDMETHOD.


  METHOD get_connection.
    DATA fromAirport TYPE /dmo/airport_from_id.
    DATA toAirport TYPE /dmo/airport_to_id.


    IF NOT line_exists( connections[ airlineid = airlineid connectionnumber = connectionnumber ] ).
      SELECT SINGLE FROM /dmo/connection FIELDS airport_from_id, airport_to_id
      WHERE carrier_id = @airlineid
      AND connection_id = @connectionnumber
      INTO ( @fromAirport, @toAirport ).


      ro_connection = NEW #( airlineid = airlineid connectionnumber = connectionnumber fromairport = fromairport toairport = toairport ).
      DATA(new_instance) = VALUE ts_instance( airlineId = airlineId connectionnumber = connectionnumber object = ro_connection ).
      INSERT new_instance INTO TABLE connections.
    ELSE.
      ro_connection = connections[ airlineId = airlineId connectionnumber = connectionnumber ]-object.
    ENDIF.


  ENDMETHOD.


ENDCLASS.
