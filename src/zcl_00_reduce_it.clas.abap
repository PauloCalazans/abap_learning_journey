CLASS zcl_00_reduce_it DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_00_reduce_it IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    TYPES: BEGIN OF t_results,
             occupied TYPE /dmo/plane_seats_occupied,
             maximum  TYPE /dmo/plane_seats_max,
           END OF t_results.


    TYPES: BEGIN OF t_results_with_Avg,
             occupied TYPE /dmo/plane_seats_occupied,
             maximum  TYPE /dmo/plane_seats_max,
             average  TYPE p LENGTH 16 DECIMALS 2,
           END OF t_results_with_avg.


    DATA flights TYPE TABLE OF /dmo/flight.
    SELECT FROM /dmo/flight FIELDS * INTO TABLE @flights.


* Result is a scalar data type
    DATA(sum) = REDUCE i( INIT total = 0 FOR line IN flights NEXT total += line-seats_occupied ).
    out->write( 'Result is a scalar data type' ).
    out->write( '_____________ ______________' ).
    out->write( sum ).
    out->write( ` ` ).


* Result is a structured data type
    DATA(results) = REDUCE t_results( INIT totals TYPE t_results
    FOR line IN flights NEXT totals-occupied += line-seats_occupied
    totals-maximum += line-seats_max ).
    out->write( 'Result is a structure' ).
    out->write( '_____________________' ).


    out->write( results ).
    out->write( ` ` ).


* Result is a structured data type
* Reduction uses a local helper variable
* Result of the reduction is always the *first* variable declared after init
    out->write( 'Result is a structure. The average is calculated using a local helper variable' ).
    out->write( '______________________________________________________________________________' ).


    DATA(result_with_Average) = REDUCE t_results_with_avg( INIT totals_avg TYPE t_results_with_avg count = 1
    FOR line IN flights NEXT totals_Avg-occupied += line-seats_occupied
    totals_avg-maximum += line-seats_max
    totals_avg-average = totals_avg-occupied / count
    count += 1 ).
    out->write( result_with_average ).


  ENDMETHOD.
ENDCLASS.
