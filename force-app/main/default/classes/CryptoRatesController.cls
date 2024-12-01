public with sharing class CryptoRatesController {
  
  @AuraEnabled(cacheable=true)
  public static List<Map<String, Object>> getCurrentRates(List<String> cryptoNames) {
    List<Map<String, Object>> result = new List<Map<String, Object>>();
    Map<String, Current_Exchange_Rates__c> ratesMap = new Map<String, Current_Exchange_Rates__c>();
    
    for (Current_Exchange_Rates__c rate : [
      SELECT Name, Current_Exchange_Rate__c, Last_Updated__c 
      FROM Current_Exchange_Rates__c
      WHERE Name IN :cryptoNames
      ]) {
        ratesMap.put(rate.Name, rate);
      }
      
      for (String cryptoName : cryptoNames) {
        if (ratesMap.containsKey(cryptoName)) {
          Current_Exchange_Rates__c rate = ratesMap.get(cryptoName);
          result.add(new Map<String, Object>{
            'name' => rate.Name,
            'rate' => rate.Exchange_Rate__c,
            'icon' => rate.Icon_URL__c,
            'lastUpdated' => rate.Last_Updated__c
          });
          } else {
            result.add(new Map<String, Object>{
              'name' => cryptoName,
              'rate' => null,
              'icon' => null,
              'lastUpdated' => null
            });
          }
        }
        
        return result;
  }
}
