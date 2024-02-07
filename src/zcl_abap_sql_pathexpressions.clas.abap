CLASS zcl_abap_sql_pathexpressions DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_abap_sql_pathexpressions IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

* Data selection
**********************************************************************

    SELECT FROM /dmo/i_connection_R
         FIELDS Airlineid,
                connectionid,

*                 _Airline.Name, "Errado
*                \_Airline-Name, "Correto
*                 _Airline-Name, "Errado
*                 _Airline~Name, "Errado
*                \_Airline~Name, "Errado
*
*                \_Airline-_Currency-CurrencyISOCode, "Errado
*                \_Airline-\_Currency-CurrencyISOCode, "Errado
*                \_Airline\_Currency-CurrencyISOCode, "Correto
*                \_Airline~\_Currency~CurrencyISOCode, "Errado
*                \_Airline\_Currency~CurrencyISOCode, "Errado
*
*                \_Airline\_Currency\_Text[                     Language = 'E' ]-CurrencyShortName AS CurrencyNameEN, "Correto
*                \_Airline\_Currency\_Text[   MANY TO ONE WHERE Language = 'D' ]-CurrencyShortName AS CurrencyNameDE, "Correto
*                \_Airline\_Currency\_Text[                     Language = 'E' ]-CurrencyShortName AS CurrencyNameEN, "Correto
*                \_Airline-\_Currency-\_Text[ MANY TO ONE WHERE Language = 'D' ]-CurrencyShortName AS CurrencyNameDE, "Errado
*                \_Airline~\_Currency~\_Text[ 1:                Language = 'E' ]-CurrencyShortName AS CurrencyNameEN, "Errado
                DepartureAirport,
                DestinationAirport

         INTO TABLE @DATA(result).

* Output
**********************************************************************
    out->write(  data = result
                 name = 'Selection result' ).

  ENDMETHOD.
ENDCLASS.
