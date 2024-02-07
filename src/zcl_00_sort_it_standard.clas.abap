CLASS zcl_00_sort_it_standard DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_00_sort_it_standard IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    TYPES: t_flights TYPE STANDARD TABLE OF /dmo/flight WITH NON-UNIQUE KEY carrier_id connection_id flight_date.
    DATA: flights TYPE t_flights.


    flights = VALUE #( ( client = sy-mandt carrier_id = 'LH' connection_id = '0400' flight_date = '20230201' plane_type_id = '747-400' price = '600' currency_code = 'EUR' )
    ( client = sy-mandt carrier_id = 'LH' connection_id = '0400' flight_date = '20230115' plane_type_id = '747-400' price = '600' currency_code = 'EUR' )
    ( client = sy-mandt carrier_id = 'QF' connection_id = '0006' flight_date = '20230112' plane_type_id = 'A380' price = '1600' currency_code = 'AUD' )
    ( client = sy-mandt carrier_id = 'AA' connection_id = '0017' flight_date = '20230110' plane_type_id = '747-400' price = '600' currency_code = 'USD' )
    ( client = sy-mandt carrier_id = 'UA' connection_id = '0900' flight_date = '20230201' plane_type_id = '777-200' price = '600' currency_code = 'USD' ) ).


    out->write( 'Contents Before Sort' ).
    out->write( '____________________' ).
    out->write( flights ).
    out->write( ` ` ).


* Sort with no additions - sort by primary table key carrier_id connection_id flight_date
    SORT flights.


    out->write( 'Effect of SORT with no additions - sort by primary table key' ).
    out->write( '____________________________________________________________' ).
    out->write( flights ).
    out->write( ` ` ).


* Sort with field list - default sort direction is ascending
    SORT flights BY currency_code plane_type_id.
    out->write( 'Effect of SORT with field list - ascending is default direction' ).
    out->write( '________________________________________________________________' ).
    out->write( flights ).
    out->write( ` ` ).


* Sort with field list and sort directions.
    SORT flights BY carrier_Id ASCENDING flight_Date DESCENDING.
    out->write( 'Effect of SORT with field list and sort direction' ).
    out->write( '_________________________________________________' ).
    out->write( flights ).
    out->write( ` ` ).
  ENDMETHOD.
ENDCLASS.
