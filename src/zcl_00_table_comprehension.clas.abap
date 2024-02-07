CLASS zcl_00_table_comprehension DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_00_table_comprehension IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    TYPES: BEGIN OF t_connection,
             carrier_id             TYPE /dmo/carrier_id,
             connection_id          TYPE /dmo/connection_id,
             departure_airport      TYPE /dmo/airport_from_id,
             departure_airport_Name TYPE /dmo/airport_Name,
           END OF t_connection.


    TYPES t_connections TYPE STANDARD TABLE OF t_connection WITH NON-UNIQUE KEY carrier_id connection_id.


    DATA connections TYPE TABLE OF /dmo/connection.
    DATA airports TYPE TABLE OF /dmo/airport.
    DATA result_table TYPE t_connections.


* Aim of the method:
* Read a list of connections from the database and use them to fill an internal table result_table.
* This contains some data from the table connections and adds the name of the departure airport.

    SELECT FROM /dmo/airport FIELDS * INTO TABLE @airports.
    SELECT FROM /dmo/connection FIELDS * INTO TABLE @connections.

    out->write( 'Connection Table' ).
    out->write( '________________' ).
    out->write( connections ).
    out->write( ` ` ).

* The VALUE expression iterates over the table connections. In each iteration, the variable line
* accesses the current line. Inside the parentheses, we build the next line of result_table by
* copying the values of line-carrier_Id, line-connection_Id and line-airport_from_id, then
* loooking up the airport name in the internal table airports using a table expression

    result_table = VALUE #( FOR line IN connections ( carrier_Id = line-carrier_id
    connection_id = line-connection_id
    departure_airport = line-airport_from_id
    departure_airport_name = airports[ airport_id = line-airport_from_id ]-name ) ).

    out->write( 'Results' ).
    out->write( '_______' ).
    out->write( result_table ).

  ENDMETHOD.
ENDCLASS.
