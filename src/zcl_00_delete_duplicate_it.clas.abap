CLASS zcl_00_delete_duplicate_it DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_00_delete_duplicate_it IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    TYPES t_flights TYPE STANDARD TABLE OF /dmo/flight WITH NON-UNIQUE KEY carrier_id connection_id flight_date.
    DATA: flights TYPE t_flights.


    flights = VALUE #( ( client = sy-mandt carrier_id = 'LH' connection_id = '0400' flight_date = '20230201' plane_type_id = '747-400' price = '600' currency_code = 'EUR' )
    ( client = sy-mandt carrier_id = 'QF' connection_id = '0006' flight_date = '20230112' plane_type_id = 'A380' price = '1600' currency_code = 'AUD' )
    ( client = sy-mandt carrier_id = 'AA' connection_id = '0017' flight_date = '20230110' plane_type_id = '747-400' price = '600' currency_code = 'USD' )
    ( client = sy-mandt carrier_id = 'LH' connection_id = '0400' flight_date = '20230301' plane_type_id = '747-400' price = '600' currency_code = 'EUR' )
    ( client = sy-mandt carrier_id = 'UA' connection_id = '0900' flight_date = '20230201' plane_type_id = '777-200' price = '600' currency_code = 'USD' )
    ( client = sy-mandt carrier_id = 'QF' connection_id = '0006' flight_date = '20230210' plane_type_id = 'A380' price = '1600' currency_code = 'AUD' ) ).


    out->write( 'Contents Before DELETE ADJACENT DUPLICATES' ).
    out->write( '____________________' ).
    out->write( flights ).
    out->write( ` ` ).


    DELETE ADJACENT DUPLICATES FROM flights.
    out->write( 'Contents after DELETE ADJACENT DUPLICATES' ).
    out->write( 'Nothing deleted - key values are not adjacent' ).
    out->write( 'Sort the table before DELETE ADJACENT DUPLICATES').
    out->write( flights ).
    out->write( ` ` ).


    SORT flights BY carrier_id connection_id flight_date.
    DELETE ADJACENT DUPLICATES FROM flights.
    out->write( 'Contents after DELETE ADJACENT DUPLICATES' ).
    out->write( 'Nothing deleted - ABAP compares all key values including flight_date, which is different for every entry' ).
    out->write( flights ).
    out->write( ` ` ).


    DELETE ADJACENT DUPLICATES FROM flights COMPARING carrier_id connection_id.
    out->write( 'Contents after DELETE ADJACENT DUPLICATES with COMPARING and field list' ).
    out->write( 'Entries with identical values of carrier_id and connection_id have been deleted' ).
    out->write( flights ).
  ENDMETHOD.
ENDCLASS.
