*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lcl_flights DEFINITION.
  PUBLIC SECTION.
    METHODS constructor.
    METHODS read_primary.
    METHODS read_non_key.
    METHODS read_secondary_1.
    METHODS read_secondary_2.
    METHODS read_secondary_3.


  PRIVATE SECTION.
    DATA connections TYPE SORTED TABLE OF Z00_flights WITH NON-UNIQUE KEY carrier_id connection_Id flight_date.
    DATA connections_sk TYPE SORTED TABLE OF Z00_flights WITH NON-UNIQUE KEY carrier_id connection_id flight_date
    WITH NON-UNIQUE SORTED KEY k_plane COMPONENTS plane_type_id.

ENDCLASS.


CLASS lcl_flights IMPLEMENTATION.

  METHOD constructor.
    SELECT FROM Z00_flights FIELDS * INTO TABLE @connections.
    SELECT FROM Z00_flights FIELDS * INTO TABLE @connections_sk.
  ENDMETHOD.

  METHOD read_non_key.
    LOOP AT connections INTO DATA(connection) WHERE plane_type_id = '737-800'.
    ENDLOOP.
  ENDMETHOD.


  METHOD read_primary.
    DATA count TYPE i VALUE 1.
    LOOP AT connections INTO DATA(connection) WHERE carrier_id = 'LH' AND connection_id = '0405' .
      count += 1.
    ENDLOOP.
  ENDMETHOD.

  METHOD read_secondary_1.
    LOOP AT connections_sk INTO DATA(connection) USING KEY k_plane WHERE plane_type_id = '737-800'.
    ENDLOOP.
  ENDMETHOD.


  METHOD read_secondary_2.
    LOOP AT connections_sk INTO DATA(connection) USING KEY k_plane WHERE plane_type_id = '737-800'.
    ENDLOOP.
  ENDMETHOD.
  METHOD read_secondary_3.
    LOOP AT connections_sk INTO DATA(connection) USING KEY k_plane WHERE plane_type_id = '737-800'.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
