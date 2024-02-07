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
        i_Connection_id TYPE /dmo/connection_id
      RAISING
        cx_abap_invalid_value.


ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.

  METHOD set_attributes.

    IF i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

    carrier_id    = i_carrier_id.
    connection_id = i_connection_id.

  ENDMETHOD.

ENDCLASS.
