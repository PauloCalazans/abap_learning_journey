CLASS zcl_00_string_functions DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_00_string_functions IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA text   TYPE string VALUE `  Let's talk about ABAP  `.

    out->write(  text ).

    Data(result) = find( val = text sub = 'A' ).
    Data(result1) = find( val = text sub = 'A' case = abap_false ).
    Data(result2) = find( val = text sub = 'A' case = abap_false occ =  -1 ).
    Data(result3) = find( val = text sub = 'A' case = abap_false occ =  -2 ).
    Data(result4) = find( val = text sub = 'A' case = abap_false occ =   2 ).
    Data(result5) = find( val = text sub = 'A' case = abap_false occ = 2 off = 10 ).
    Data(result6) = find( val = text sub = 'A' case = abap_false occ = 2 off = 10 len = 4 ).

    out->write( |RESULT = { result } | ).
    out->write( |RESULT1 = { result1 } | ).
    out->write( |RESULT2 = { result2 } | ).
    out->write( |RESULT3 = { result3 } | ).
    out->write( |RESULT4 = { result4 } | ).
    out->write( |RESULT5 = { result5 } | ).
    out->write( |RESULT6 = { result6 } | ).

  ENDMETHOD.
ENDCLASS.
