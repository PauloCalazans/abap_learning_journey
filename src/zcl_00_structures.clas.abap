CLASS zcl_00_structures DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_00_structures IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

* Example 1 : Motivation for Structured Variables
**********************************************************************

    DATA connection_full TYPE /DMO/I_Connection.

    SELECT SINGLE
     FROM /dmo/I_Connection
   FIELDS AirlineID, ConnectionID, DepartureAirport, DestinationAirport,
          DepartureTime, ArrivalTime, Distance, DistanceUnit
    WHERE AirlineId    = 'LH'
      AND ConnectionId = '0400'
     INTO @connection_full.

    out->write(  `--------------------------------------` ).
    out->write(  `Example 1: CDS View as Structured Type` ).
    out->write( connection_full ).

* Example 2: Global Structured Type
**********************************************************************

    DATA message TYPE symsg.

    out->write(  `---------------------------------` ).
    out->write(  `Example 2: Global Structured Type` ).
    out->write( message ).

* Example 3 : Local Structured Type
**********************************************************************

    TYPES: BEGIN OF st_connection,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
             carrier_name    TYPE /dmo/carrier_name,
           END OF st_connection.

    DATA connection TYPE st_connection.

    SELECT SINGLE
      FROM /DMO/I_Connection
    FIELDS DepartureAirport, DestinationAirport, \_Airline-Name
     WHERE AirlineID = 'LH'
       AND ConnectionID = '0400'
      INTO @connection.

    out->write(  `---------------------------------------` ).
    out->write(  `Example 3: Global Local Structured Type` ).
    out->write( connection ).

* Example 4 : Nested Structured Type
**********************************************************************

    TYPES: BEGIN OF st_nested,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
             message         TYPE symsg,
             carrier_name    TYPE /dmo/carrier_name,
           END OF st_nested.

    DATA connection_nested TYPE st_nested.

    out->write(  `---------------------------------` ).
    out->write(  `Example 4: Nested Structured Type` ).
    out->write( connection_nested ).

  ENDMETHOD.
ENDCLASS.
