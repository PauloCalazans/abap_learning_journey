CLASS zcl_abap_sql DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_abap_sql IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    TYPES: BEGIN OF st_connection,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
             carrier_name    TYPE /dmo/carrier_name,
           END OF st_connection.

    TYPES: BEGIN OF st_connection_short,
             DepartureAirport   TYPE /dmo/airport_from_id,
             DestinationAirport TYPE /dmo/airport_to_id,
           END OF st_connection_short.


    DATA connection TYPE st_connection.

    DATA connection_short TYPE st_connection_short.

    DATA connection_full TYPE /DMO/I_Connection.

* Example 1: Correspondence between FIELDS and INTO
**********************************************************************

    SELECT SINGLE
       FROM /DMO/I_Connection
     FIELDS DepartureAirport, DestinationAirport, \_Airline-Name
      WHERE AirlineID = 'LH'
        AND ConnectionID = '0400'
       INTO @connection.

    out->write(  `------------------------------` ).
    out->write(  `Example 1: Field List and INTO` ).
    out->write( connection ).

* Example 2: FIELDS *
**********************************************************************

    SELECT SINGLE
      FROM /DMO/I_Connection
    FIELDS *
     WHERE AirlineID = 'LH'
       AND ConnectionID = '0400'
      INTO @connection_full.

    out->write(  `----------------------------` ).
    out->write(  `Example 2: FIELDS * and INTO` ).
    out->write( connection_full ).

* Example 3: INTO CORRESPONDING FIELDS
**********************************************************************

    SELECT SINGLE
      FROM /DMO/I_Connection
    FIELDS *
     WHERE AirlineID    = 'LH'
       AND ConnectionID = '0400'
      INTO CORRESPONDING FIELDS OF @connection_short.

    out->write(  `----------------------------------------------------` ).
    out->write(  `Example 3: FIELDS * and INTO CORRESPONDING FIELDS OF` ).
    out->write( connection_short ).

* Example 4: Alias Names for Fields
**********************************************************************

    CLEAR connection.

    SELECT SINGLE
      FROM /DMO/I_Connection
    FIELDS DepartureAirport AS airport_from_id,
           \_Airline-Name   AS carrier_name
     WHERE AirlineID    = 'LH'
       AND ConnectionID = '0400'
      INTO CORRESPONDING FIELDS OF @connection.

    out->write(  `---------------------------------------------------` ).
    out->write(  `Example 4: Aliases and INTO CORRESPONDING FIELDS OF` ).
    out->write( connection ).

* Example 5: Inline Declaration
**********************************************************************

    SELECT SINGLE
      FROM /DMO/I_Connection
    FIELDS DepartureAirport,
           DestinationAirport AS ArrivalAirport,
           \_Airline-Name     AS carrier_name
     WHERE AirlineID    = 'LH'
       AND ConnectionID = '0400'
      INTO @DATA(connection_inline).

    out->write(  `-----------------------------------------` ).
    out->write(  `Example 5: Aliases and Inline Declaration` ).
    out->write( connection_inline ).

* Example 6: Joins
**********************************************************************

    SELECT SINGLE
      FROM (  /dmo/connection AS c
              LEFT OUTER JOIN /dmo/airport AS f
                ON c~airport_from_id = f~airport_id
           )
      LEFT OUTER JOIN /dmo/airport AS t
        ON c~airport_to_id = t~airport_id
    FIELDS c~airport_from_id, c~airport_to_id,
           f~name AS airport_from_name, t~name AS airport_to_name
     WHERE c~carrier_id    = 'LH'
       AND c~connection_id = '0400'
      INTO @DATA(connection_join).

    out->write(  `------------------------------------------` ).
    out->write(  `Example 6: Join of Connection and Airports` ).
    out->write( connection_join ).

  ENDMETHOD.
ENDCLASS.
