*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_connection DEFINITION.
  PUBLIC SECTION.
    DATA carrier_id    TYPE /dmo/carrier_id.
    DATA connection_id TYPE /dmo/connection_id.
    CLASS-DATA conn_counter TYPE i.
  PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.
ENDCLASS.
