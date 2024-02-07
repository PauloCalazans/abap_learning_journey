CLASS zcl_00_join_abap_sql DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_00_join_abap_sql IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    SELECT FROM /dmo/carrier INNER JOIN /dmo/connection
*    SELECT FROM /dmo/carrier AS a INNER JOIN /dmo/connection AS c
             ON /dmo/carrier~carrier_id = /dmo/connection~carrier_id

         FIELDS /dmo/carrier~carrier_id,
                /dmo/carrier~name AS carrier_name,
                /dmo/connection~connection_id,
                /dmo/connection~airport_from_id,
                /dmo/connection~airport_to_id

          WHERE /dmo/carrier~currency_code = 'EUR'
           INTO TABLE @DATA(result).

    out->write(
      EXPORTING
        data   = result
        name   = 'RESULT'
    ).


    SELECT FROM /dmo/Agency AS a
*                INNER JOIN /dmo/customer AS c
              LEFT OUTER JOIN /dmo/customer AS c
*          RIGHT OUTER JOIN /dmo/customer AS c
                ON a~city         = c~city

            FIELDS agency_id,
                   name AS Agency_name,
                   a~city AS agency_city,
                   c~city AS customer_city,
                   customer_id,
                   last_name AS customer_name

             WHERE ( c~customer_id < '000010' OR c~customer_id IS NULL )
               AND ( a~agency_id   < '070010' OR a~agency_id   IS NULL )

              INTO TABLE @DATA(result_Join).


    out->write(
      EXPORTING
        data   = result_join
        name   = 'RESULT_JOIN'
    ).


  ENDMETHOD.
ENDCLASS.
