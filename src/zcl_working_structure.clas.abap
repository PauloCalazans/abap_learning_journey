CLASS zcl_working_structure DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_working_structure IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    TYPES: BEGIN OF st_connection,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
             carrier_name    TYPE /dmo/carrier_name,
           END OF st_connection.

    TYPES: BEGIN OF st_connection_nested,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
             message         TYPE symsg,
             carrier_name    TYPE /dmo/carrier_name,
           END OF st_connection_nested.

    DATA connection TYPE st_connection.
    DATA connection_nested TYPE st_Connection_nested.

* Example 1: Access to structure components
**********************************************************************

    connection-airport_from_id = 'ABC'.
    connection-airport_to_id   = 'XYZ'.
    connection-carrier_name    = 'My Airline'.

    "Access to sub-components of nested structure
    connection_nested-message-msgty = 'E'.
    connection_nested-message-msgid = 'ABC'.
    connection_nested-message-msgno = '123'.

* Example 2: Filling a structure with VALUE #(    ).
**********************************************************************

    CLEAR connection.

    connection = VALUE #( airport_from_id = 'ABC'
                          airport_to_id   = 'XYZ'
                          carrier_name    = 'My Airline'
                        ).

    " Nested VALUE to fill nested structure
    connection_nested = VALUE #( airport_from_id = 'ABC'
                                 airport_to_id   = 'XYZ'
                                 message         = VALUE #( msgty = 'E'
                                                            msgid = 'ABC'
                                                            msgno = '123' )
                                 carrier_name    = 'My Airline'
                         ).

* Example 3: Wrong result after direct assignment
**********************************************************************

    connection_nested = connection.

    out->write(  `-------------------------------------------------------------` ).
    out->write(  `Example 3: Wrong Result after direct assignment` ).

    out->write( data = connection
                name = `Source Structure:` ).

    out->write( |Component connection_nested-message-msgid: { connection_nested-message-msgid }| ).
    out->write( |Component connection_nested-carrier_name : { connection_nested-carrier_name  }| ).

* Example 4: Assigning Structures using CORRESPONDING #( )
**********************************************************************
    CLEAR connection_nested.
    connection_nested = CORRESPONDING #(  connection ).  "

    out->write(  `-------------------------------------------------------------` ).
    out->write(  `Example 4: Correct Result after assignment with CORRESPONDING` ).

    out->write( data = connection
                name = `Source Structure:` ).

    out->write( |Component connection_nested-message-msgid: { connection_nested-message-msgid }| ).
    out->write( |Component connection_nested-carrier_name : { connection_nested-carrier_name  }| ).

  ENDMETHOD.
ENDCLASS.
