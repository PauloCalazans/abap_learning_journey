CLASS zcl_00_arithmetic_exp_abap_sql DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_00_arithmetic_exp_abap_sql IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    SELECT FROM /dmo/flight
            FIELDS seats_max,
                   seats_occupied,

                   seats_max - seats_occupied           AS seats_avaliable,

                   (   CAST( seats_occupied AS FLTP )
                     * CAST( 100 AS FLTP )
                   ) / CAST(  seats_max AS FLTP )       AS percentage_fltp

              WHERE carrier_id = 'LH' AND connection_id = '0400'
               INTO TABLE @DATA(result).

    out->write(
      EXPORTING
        data   = result
        name   = 'RESULT'
    ).

  ENDMETHOD.
ENDCLASS.
