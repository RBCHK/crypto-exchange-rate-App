public with sharing class CryptoRateService {

  // Method to apply the exchange rate to opportunities based on the selected cryptocurrency
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
}