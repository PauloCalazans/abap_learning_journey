@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Associations CDS View Learn. Journey SAP'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity z00_cds_associations
  as select from /DMO/I_Connection_R


{
    key AirlineID,
    key ConnectionID,

        _Airline._Currency._Text.CurrencyName

        //_Airline._Currency._Text[ Language = 'E' ].CurrencyName

        //_Airline._Currency._Text[ 1: Language = 'E' ].CurrencyName
  }
where
      AirlineID    = 'AA'
  and ConnectionID = '0017'

