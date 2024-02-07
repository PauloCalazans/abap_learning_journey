@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for Z00_R_CONNECTION'
define root view entity Z00_C_CONNECTION
  provider contract transactional_query
  as projection on Z00_R_CONNECTION
{
  key UUID,
  
  @Consumption.valueHelpDefinition:     
      [{ entity: { name:    'Z00_I_CarrierVH',
                   element: 'CarrierID'
                 }  
      }]             
  CarrierID,
  ConnectionID,
  AirportFromID,
  CityFrom,
  CountryFrom,
  AirportToID,
  CityTo,
  CountryTo,
  LocalLastChangedAt
  
}
