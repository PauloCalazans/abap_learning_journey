CLASS zcl_00_complex_it DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_00_complex_it IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    TYPES: BEGIN OF st_connection,
             carrier_id      TYPE /dmo/carrier_id,
             connection_id   TYPE /dmo/connection_id,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
             carrier_name    TYPE /dmo/carrier_name,
           END OF st_connection.


* Example 1 : Simple and Complex Internal Table
**********************************************************************

    " simple table (scalar row type)
    DATA numbers TYPE TABLE OF i.
    " complex table (structured row type)
    DATA connections TYPE TABLE OF st_connection.

    out->write(  `--------------------------------------------` ).
    out->write(  `Example 1: Simple and Complex Internal Table` ).
    out->write( data = numbers
                name = `Simple Table NUMBERS:` ).
    out->write( data = connections
                name = `Complex Table CONNECTIONS:` ).

* Example 2 : Complex Internal Tables
**********************************************************************

    " standard table with non-unique standard key (short form)
    DATA connections_1 TYPE TABLE OF st_connection.

    " standard table with non-unique standard key (explicit form)
    DATA connections_2 TYPE STANDARD TABLE OF st_connection
                            WITH NON-UNIQUE DEFAULT KEY.

    " sorted table with non-unique explicit key
    DATA connections_3  TYPE SORTED TABLE OF st_connection
                             WITH NON-UNIQUE KEY airport_from_id
                                                 airport_to_id.

    " sorted hashed with unique explicit key
    DATA connections_4  TYPE HASHED TABLE OF st_connection
                             WITH UNIQUE KEY carrier_id
                                             connection_id.

* Example 3 : Local Table Type
**********************************************************************

    TYPES tt_connections TYPE SORTED TABLE OF st_connection
                              WITH UNIQUE KEY carrier_id
                                              connection_id.

    DATA connections_5 TYPE tt_connections.

* Example 4 : Global Table Type
**********************************************************************

    DATA flights  TYPE /dmo/t_flight.

    out->write(  `------------------------------------------` ).
    out->write(  `Example 4: Global Table TYpe /DMO/T_FLIGHT` ).
    out->write(  data = flights
                 name = `Internal Table FLIGHTS:` ).

  ENDMETHOD.
ENDCLASS.
