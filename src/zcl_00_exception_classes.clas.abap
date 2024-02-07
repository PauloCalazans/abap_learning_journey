CLASS zcl_00_exception_classes DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_00_exception_classes IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA number1 TYPE i VALUE 2000000000.
    DATA number2 TYPE p LENGTH 2 DECIMALS 1 VALUE '0.5'.
    DATA result TYPE i.

    TRY.

        result = number1 / number2.

      CATCH cx_sy_arithmetic_overflow.
        out->write( 'Arithmetic Overflow' ).
      CATCH cx_sy_zerodivide.
        out->write( 'Division by zero' ).
    ENDTRY.

    number2 = 0.
    TRY.

        result = number1 / number2.


      CATCH cx_sy_arithmetic_overflow.
        out->write( 'Arithmetic Overflow' ).
      CATCH cx_sy_zerodivide.
        out->write( 'Division by zero' ).
    ENDTRY.

    TRY.
        result = number1 / number2.

      CATCH cx_sy_arithmetic_overflow cx_sy_zerodivide.
        out->write( 'Arithmetic overflow or division by zero' ).
    ENDTRY.

    TRY.
        result = number1 / number2.
      CATCH cx_sy_arithmetic_error.
        out->write( 'Caught both exceptions using their common superclass' ).
    ENDTRY.


    TRY.
        result = number1 / number2.
      CATCH cx_root.
        out->write( 'Caught any exception using CX_ROOT' ).
    ENDTRY.


    TRY.
        result = number1 / number2.
      CATCH cx_root INTO DATA(Exception).
        out->write( 'Used INTO to intercept the exception object' ).
        out->write( 'The get_Text( ) method returns the following error text: ' ).
        out->write( Exception->get_text( ) ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
