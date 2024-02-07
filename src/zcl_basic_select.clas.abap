CLASS zcl_basic_select DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_basic_select IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA airport_from_id TYPE /DMO/airport_from_id.
    DATA airport_to_id   TYPE /DMO/airport_to_id.

    DATA airports TYPE TABLE OF /DMO/airport_from_id.

* Example 1: Single field from Single Record
**********************************************************************
    SELECT SINGLE
      FROM /dmo/connection
      FIELDS airport_from_id
      WHERE carrier_id    = 'LH'
        AND connection_id = '0400'
        INTO @airport_from_id.

    out->write( `----------`  ).
    out->write( `Example 1:`  ).

    out->write( |Flight LH 400 departs from {  airport_from_id }.| ).

* Example 2: Multiple Fields from Single Record
**********************************************************************
    SELECT SINGLE
      FROM /dmo/connection
      FIELDS airport_from_id, airport_to_id
      WHERE carrier_id    = 'LH'
        AND connection_id = '0400'
        INTO (  @airport_from_id, @airport_to_id ).

    out->write( `----------`  ).
    out->write( `Example 2:`  ).

    out->write( |Flight LH 400 flies from {  airport_from_id } to { airport_to_id  }| ).

* Example 3: Empty Result and sy-subrc
**********************************************************************
    SELECT SINGLE
      FROM /dmo/connection
      FIELDS airport_from_id
      WHERE carrier_id    = 'XX'
        AND connection_id = '1234'
        INTO @airport_from_id.

    IF sy-subrc = 0.

      out->write( `----------`  ).
      out->write( `Example 3:`  ).
      out->write( |Flight XX 1234 departs from {  airport_from_id }.| ).

    ELSE.

      out->write( `----------`  ).
      out->write( `Example 3:`  ).
      out->write( |There is no flight XX 1234, but still airport_from_id = {  airport_from_id }!| ).

    ENDIF.

  ENDMETHOD.
ENDCLASS.
