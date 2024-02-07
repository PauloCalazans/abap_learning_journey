CLASS zcl_00_description_functions DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_00_description_functions IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA text    TYPE string VALUE `  ABAP  `.
    DATA substring TYPE string VALUE `AB`.
    DATA offset    TYPE i      VALUE 1.

* Call different description functions
******************************************************************************
    DATA(result) = strlen(     text ).
    DATA(result1) = numofchar(  text ).

    DATA(result2) = count(             val = text sub = substring off = offset ).
    DATA(result3) = find(             val = text sub = substring off = offset ).

    DATA(result4) = count_any_of(     val = text sub = substring off = offset ).
    DATA(result5) = find_any_of(      val = text sub = substring off = offset ).

    DATA(result6) = count_any_not_of( val = text sub = substring off = offset ).
    DATA(result7) = find_any_not_of(  val = text sub = substring off = offset ).

    out->write( |Text       = `{ text }`| ).
    out->write( |Substring  = `{ substring }` | ).
    out->write( |Offset     = { offset } | ).
    out->write( |Result     = { result } | ).
    out->write( |Result1    = { result1 } | ).
    out->write( |Result2    = { result2 } | ).
    out->write( |Result3    = { result3 } | ).
    out->write( |Result4    = { result4 } | ).
    out->write( |Result5    = { result5 } | ).
    out->write( |Result6    = { result6 } | ).
    out->write( |Result7    = { result7 } | ).

  ENDMETHOD.
ENDCLASS.
