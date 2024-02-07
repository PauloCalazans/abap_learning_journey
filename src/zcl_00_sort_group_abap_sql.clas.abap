CLASS zcl_00_sort_group_abap_sql DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_00_sort_group_abap_sql IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.


    SELECT FROM /dmo/flight
         FIELDS carrier_id,
                connection_id,
                flight_date,
                seats_max - seats_occupied AS seats
          WHERE carrier_id     = 'AA'
            AND plane_type_id  = 'A320-200'
*       ORDER BY seats_max - seats_occupied DESCENDING,
*                flight_date                ASCENDING
           INTO TABLE @DATA(result).

    out->write(
      EXPORTING
        data   = result
        name   = 'RESULT'
    ).



    SELECT FROM /dmo/connection
       FIELDS
           DISTINCT
              airport_from_id,
              distance_unit

     ORDER BY airport_from_id
         INTO TABLE @DATA(result2).

    out->write(
      EXPORTING
        data   = result
        name   = 'RESULT'
    ).



    SELECT FROM /dmo/connection
         FIELDS carrier_id,
                connection_id,
                airport_from_id,
                distance
          WHERE carrier_id = 'LH'
           INTO TABLE @DATA(result_raw).


    out->write(
      EXPORTING
        data   = result_raw
        name   = 'RESULT_RAW'
    ).

*********************************************************************

    SELECT FROM /dmo/connection
         FIELDS MAX( distance ) AS max,
                MIN( distance ) AS min,
                SUM( distance ) AS sum,
                AVG( distance ) AS average,
                COUNT( * ) AS count,
                COUNT( DISTINCT airport_from_id ) AS count_dist

          WHERE carrier_id = 'LH'
           INTO TABLE @DATA(result_aggregate).

    out->write(
      EXPORTING
        data   = result_aggregate
        name   = 'RESULT_AGGREGATED'
    ).


    SELECT FROM /dmo/connection
         FIELDS
            carrier_id,

                MAX( distance ) AS max,
                MIN( distance ) AS min,
                SUM( distance ) AS sum,
                COUNT( * ) AS count

     GROUP BY carrier_id
         INTO TABLE @DATA(result3).
    out->write(
      EXPORTING
        data   = result
        name   = 'RESULT'
    ).

  ENDMETHOD.
ENDCLASS.
