*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lcl_connection DEFINITION.
  PUBLIC SECTION.

* Attributes
    DATA carrier_id    TYPE /dmo/carrier_id.
    DATA connection_id TYPE /dmo/connection_id.

* Methods
    METHODS set_attributes
      IMPORTING
        i_carrier_id    TYPE /dmo/carrier_id  DEFAULT 'LH'
        i_Connection_id TYPE /dmo/connection_id.

    " Functional Method
    METHODS get_output
      RETURNING VALUE(r_output) TYPE string_table.

*  PROTECTED SECTION.

*  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.

  METHOD set_attributes.

    carrier_id    = i_carrier_id.
    connection_id = i_connection_id.

  ENDMETHOD.

  METHOD get_output.

    APPEND |------------------------------| TO r_output.
    APPEND |Carrier:     { carrier_id    }| TO r_output.
    APPEND |Connection:  { connection_id }| TO r_output.

  ENDMETHOD.

ENDCLASS.
