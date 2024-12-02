public with sharing class CryptoRatesController {
  
  // Method to get the current exchange rates from the Current_Exchange_Rates__c object
  @AuraEnabled(cacheable=true)
  public static List<Map<String, Object>> getCurrentRates() {
    List<Map<String, Object>> result = new List<Map<String, Object>>();
    
    List<Current_Exchange_Rates__c> currentRates = [
      SELECT CreatedById, Name, Current_Exchange_Rate__c, Last_Updated__c
      FROM Current_Exchange_Rates__c
    ];

    for (Current_Exchange_Rates__c rate : currentRates) {
      result.add(new Map<String, Object>{
        'id' => rate.CreatedById,
        'name' => rate.Name,
        'rate' => rate.Current_Exchange_Rate__c,
        'lastUpdated' => rate.Last_Updated__c
      });
    }

    return result;
  }
}
