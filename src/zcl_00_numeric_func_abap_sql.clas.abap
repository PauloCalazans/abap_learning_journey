CLASS zcl_00_numeric_func_abap_sql DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_00_numeric_func_abap_sql IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    SELECT seats_max,
           seats_occupied,
           (   CAST( seats_occupied AS FLTP )
             * CAST( 100 AS FLTP )
           ) / CAST(  seats_max AS FLTP )                  AS percentage_fltp,

           div( seats_occupied * 100 , seats_max )         AS percentage_int,

           division(  seats_occupied * 100, seats_max, 2 ) AS percentage_dec
            FROM /dmo/flight
             WHERE carrier_id    = 'LH'
               AND connection_id = '0400'
              INTO TABLE @DATA(result).

    out->write(
      EXPORTING
        data   = result
        name   = 'RESULT'
    ).

  ENDMETHOD.

ENDCLASS.
