trigger UpdateCryptoRatesTrigger on Current_Exchange_Rates__c (after insert, after update) {
  CryptoRateService.updateOpportunitiesWithNewRate();
}