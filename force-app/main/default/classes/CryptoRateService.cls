public with sharing class CryptoRateService {

  // to apply the exchange rate to opportunities based on the selected cryptocurrency
  public static void applyCryptoExchangeRate(List<Opportunity> opportunities) {
    List<Map<String, Object>> currentRates = CryptoRatesController.getCurrentRates();

    for (Opportunity opp : opportunities) {
      
      String selectedCurrency = opp.Cryptocurrency__c;
      
      if (String.isNotBlank(selectedCurrency)) {
        for (Map<String, Object> rate : currentRates) {
          if (rate.get('name') == selectedCurrency) {
            Decimal cryptoRate = (Decimal) rate.get('rate');
            opp.Amount_In_Crypto__c = opp.Amount / cryptoRate;
            break;
          } else {
            opp.Amount_In_Crypto__c = null;
          }
        }
      }
    }
  }

  //updates AmountInCrypto__c in open Opportunities when the exchange rate changes
  public static void updateOpportunitiesWithNewRate() {
    List<Map<String, Object>> currentRates = CryptoRatesController.getCurrentRates();

    List<Opportunity> openOpportunities = [
      SELECT Id, Amount, Cryptocurrency__c, Amount_In_Crypto__c
      FROM Opportunity
      WHERE StageName != 'Closed' AND Cryptocurrency__c != NULL
    ];
    
    for (Opportunity opp : openOpportunities) {
      for (Map<String, Object> rate : currentRates) {
        if (rate.get('name') == opp.Cryptocurrency__c) {
          Decimal cryptoRate = (Decimal) rate.get('rate');
          opp.Amount_In_Crypto__c = opp.Amount / cryptoRate;
        }
      }
    }
    
    update openOpportunities;
  }
}