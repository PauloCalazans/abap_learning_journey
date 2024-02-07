@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS View Agregations Joins and Unions'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Z00_CDS_AGREGATION as 
select from /DMO/I_Connection_R
  {
    key AirlineID,
    key ConnectionID,

        concat_with_space(
          concat_with_space(
            concat_with_space(
              concat(
                 concat( AirlineID,
                         ConnectionID ),
                 ': ' ),
              DepartureAirport, 1 ),
           '->', 1 ),
        DestinationAirport, 1 ) as Description,
        
         avg( _Flight.OccupiedSeats as abap.dec(15,2)) as AverageOccupation
 

        // ,
        //count( distinct _Flight.FlightDate ) as NumberOfFlights,
        //min( _Flight.FlightDate )            as FirstFlightDate,
        //sum( _Flight.OccupiedSeats )         as TotalOccupiedSeats,
        //avg( _Flight.OccupiedSeats )         as AverageOccupation
  }
group by
    AirlineID,
    ConnectionID,
    DepartureAirport,
    DestinationAirport

