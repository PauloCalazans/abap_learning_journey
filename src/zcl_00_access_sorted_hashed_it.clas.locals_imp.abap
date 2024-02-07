*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lcl_flights DEFINITION.
  PUBLIC SECTION.
    METHODS constructor.
    METHODS access_standard.
    METHODS access_sorted.
    METHODS access_hashed.
  PRIVATE SECTION.

    DATA standard_table TYPE STANDARD TABLE OF z00_flights WITH NON-UNIQUE KEY carrier_id connection_id flight_date.
    DATA sorted_table TYPE SORTED TABLE OF z00_flights WITH NON-UNIQUE KEY carrier_id connection_id flight_date.
    DATA hashed_table TYPE HASHED TABLE OF z00_flights WITH UNIQUE KEY carrier_id connection_id flight_date.

    DATA key_carrier_id TYPE /dmo/carrier_id.
    DATA key_connection_id TYPE /dmo/connection_id.
    DATA key_date TYPE /dmo/flight_date.
    METHODS set_line_to_read.

ENDCLASS.


CLASS lcl_flights IMPLEMENTATION.

  METHOD access_hashed.
    DATA(result) = hashed_table[ carrier_Id = me->key_carrier_id connection_Id = me->key_connection_id flight_date = me->key_date ].
  ENDMETHOD.


  METHOD access_sorted.
    DATA(result) = sorted_table[ carrier_Id = me->key_carrier_id connection_Id = me->key_connection_id flight_date = me->key_date ].
  ENDMETHOD.


  METHOD constructor.
    SELECT FROM z00_flights FIELDS * INTO TABLE @standard_table.
    SELECT FROM z00_flights FIELDS * INTO TABLE @sorted_table.
    SELECT FROM z00_flights FIELDS * INTO TABLE @hashed_table.

    set_line_to_read( ).
  ENDMETHOD.


  METHOD access_standard.
    DATA(result) = standard_table[ carrier_Id = me->key_carrier_id connection_Id = me->key_connection_id flight_date = me->key_date ].
  ENDMETHOD.


  METHOD set_line_to_read.
    DATA(line) = standard_table[ CONV i( lines( standard_table ) * '0.65' ) ].
    me->key_carrier_id = line-carrier_Id.
    me->key_connection_Id = line-connection_id.
    me->key_date = line-flight_date.

  ENDMETHOD.


ENDCLASS.
