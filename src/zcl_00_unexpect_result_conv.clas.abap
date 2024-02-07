CLASS zcl_00_unexpect_result_conv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_00_unexpect_result_conv IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA var_date TYPE d.
    DATA var_int TYPE i.
    DATA var_string TYPE string.
    DATA var_n TYPE n LENGTH 4.

    var_date = cl_abap_context_info=>get_system_date( ).
    var_int = var_date.

    out->write( |Date as date| ).
    out->write( var_date ).
    out->write( |Date assigned to integer| ).
    out->write( var_int ).

    var_string = `R2D2`.
    var_n = var_string.

    out->write( |String| ).
    out->write( var_string ).
    out->write( |String assigned to type N| ).
    out->write( var_n ).
  ENDMETHOD.

ENDCLASS.
