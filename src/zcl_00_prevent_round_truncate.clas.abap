CLASS zcl_00_prevent_round_truncate DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_00_prevent_round_truncate IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA var_date TYPE d.
    DATA var_pack TYPE p LENGTH 3 DECIMALS 2.
    DATA var_string TYPE string.
    DATA var_char TYPE c LENGTH 3.


    var_pack = 1 / 8.
    out->write( |1/8 = { var_pack NUMBER = USER }| ).


    TRY.
        var_pack = EXACT #( 1 / 8 ).
      CATCH cx_sy_conversion_error.
        out->write( |1/8 has to be rounded. EXACT triggered an exception| ).
    ENDTRY.


    var_string = 'ABCDE'.
    var_Char = var_string.
    out->write( var_char ).


    TRY.
        var_char = EXACT #( var_string ).
      CATCH cx_sy_conversion_error.
        out->write( 'String has to be truncated. EXACT triggered an exception' ).
    ENDTRY.


    var_date = 'ABCDEFGH'.
    out->write( var_Date ).


    TRY.
        var_date = EXACT #( 'ABCDEFGH' ).
      CATCH cx_sy_conversion_error.
        out->write( |ABCDEFGH is not a valid date. EXACT triggered an exception| ).
    ENDTRY.


    var_date = '20221232'.
    out->write( var_date ).


    TRY.
        var_date = EXACT #( '20221232' ).
      CATCH cx_sy_conversion_error.
        out->write( |2022-12-32 is not a valid date. EXACT triggered an exception| ).
    ENDTRY.


  ENDMETHOD.
ENDCLASS.
