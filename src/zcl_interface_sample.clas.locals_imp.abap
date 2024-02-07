*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

INTERFACE lif_partner.
  METHODS get_partner_attributes.
ENDINTERFACE.

CLASS lcl_travel_Agency DEFINITION.
  PUBLIC SECTION.
ENDCLASS.

CLASS lcl_airline DEFINITION.
  PUBLIC SECTION.

    INTERFACES lif_Partner.

    TYPES: BEGIN OF ts_detail,
             name  TYPE string,
             value TYPE string,
           END OF ts_detail,
           tt_Details TYPE SORTED TABLE OF ts_detail WITH UNIQUE KEY name.

    METHODS get_details RETURNING VALUE(rt_details) TYPE tt_details.
ENDCLASS.

CLASS lcl_car_Rental DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_Partner.
    TYPES: BEGIN OF ts_info,
             name  TYPE c LENGTH 20,
             value TYPE c LENGTH 20,
           END OF ts_info,
           tt_Info TYPE SORTED TABLE OF ts_info WITH UNIQUE KEY name.

    METHODS get_information RETURNING VALUE(rt_details) TYPE tt_info.
ENDCLASS.

CLASS lcl_airline IMPLEMENTATION.

  METHOD get_details.

  ENDMETHOD.

  METHOD lif_partner~get_partner_attributes.

  ENDMETHOD.

ENDCLASS.


CLASS lcl_car_rental IMPLEMENTATION.

  METHOD get_information.

  ENDMETHOD.

  METHOD lif_partner~get_partner_attributes.

  ENDMETHOD.


ENDCLASS.
