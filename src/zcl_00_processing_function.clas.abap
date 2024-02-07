CLASS zcl_00_processing_function DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_00_processing_function IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA text TYPE string      VALUE ` SAP BTP,   ABAP Environment  `.

* Change Case of characters
**********************************************************************
    out->write( |TO_UPPER         = {   to_upper(  text ) } | ).
    out->write( |TO_LOWER         = {   to_lower(  text ) } | ).
    out->write( |TO_MIXED         = {   to_mixed(  text ) } | ).
    out->write( |FROM_MIXED       = { from_mixed(  text ) } | ).


* Change order of characters
**********************************************************************
    out->write( |REVERSE             = {  reverse( text ) } | ).
    out->write( |SHIFT_LEFT  (places)= {  shift_left(  val = text places   = 3  ) } | ).
    out->write( |SHIFT_RIGHT (places)= {  shift_right( val = text places   = 3  ) } | ).
    out->write( |SHIFT_LEFT  (circ)  = {  shift_left(  val = text circular = 3  ) } | ).
    out->write( |SHIFT_RIGHT (circ)  = {  shift_right( val = text circular = 3  ) } | ).


* Extract a Substring
**********************************************************************
    out->write( |SUBSTRING       = {  substring(        val = text off = 4 len = 10 ) } | ).
    out->write( |SUBSTRING_FROM  = {  substring_from(   val = text sub = 'ABAP'     ) } | ).
    out->write( |SUBSTRING_AFTER = {  substring_after(  val = text sub = 'ABAP'     ) } | ).
    out->write( |SUBSTRING_TO    = {  substring_to(     val = text sub = 'ABAP'     ) } | ).
    out->write( |SUBSTRING_BEFORE= {  substring_before( val = text sub = 'ABAP'     ) } | ).


* Condense, REPEAT and Segment
**********************************************************************
    out->write( |CONDENSE         = {   condense( val = text ) } | ).
    out->write( |REPEAT           = {   repeat(   val = text occ = 2 ) } | ).

    out->write( |SEGMENT1         = {   segment(  val = text sep = ',' index = 1 ) } |  ).
    out->write( |SEGMENT2         = {   segment(  val = text sep = ',' index = 2 ) } |  ).

  ENDMETHOD.
ENDCLASS.
