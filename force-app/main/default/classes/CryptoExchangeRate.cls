// This class is responsible for managing cryptocurrency exchange rates. 
public with sharing class CryptoExchangeRate {

  // This method fetches live rates from the external API and saves them into Current_Exchange_Rates__c and Historical_Exchange_Rates__c.
  @AuraEnabled
  public static void getCryptoRates() {
    String url = getAPIUrl();
    String currencyCode = 'usd';

    HttpRequest req = new HttpRequest();
    req.setEndpoint(url);
    req.setMethod('GET');
    req.setHeader('Content-Type', 'application/json');
    
    Http http = new Http();
    HttpResponse res = http.send(req);
    
    if (res.getStatusCode() == 200) {
      Map<String, Object> result = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
      List<Current_Exchange_Rates__c> currentRatesToInsert = new List<Current_Exchange_Rates__c>();
      List<Historical_Exchange_Rates__c> historicalRatesToInsert = new List<Historical_Exchange_Rates__c>();

      for (String cryptoName : result.KeySet()) {
        Map<String, Object> cryptoData = (Map<String, Object>)result.get(cryptoName);
        Decimal cryptoRate = (Decimal)cryptoData.get(currencyCode);

        currentRatesToInsert.add(new Current_Exchange_Rates__c(
          Name = cryptoName,
          Current_Exchange_Rate__c = cryptoRate,
          Last_Updated__c = System.Now()
        ));

        historicalRatesToInsert.add(new Historical_Exchange_Rates__c(
          Name = cryptoName,
          Exchange_Rate__c = cryptoRate,
          Date_Recorded__c = System.Now()
        ));
      }

      if(!currentRatesToInsert.isEmpty()){
        try {
          delete [SELECT Id FROM Current_Exchange_Rates__c];
          insert currentRatesToInsert;
        } catch (DmlException e) {
          System.debug('Error upserting current rates: ' + e.getMessage());
          throw new AuraHandledException('Error while upserting current exchange rates. Please contact your administrator: ' + res.getStatus());
        }
      }

      if(!historicalRatesToInsert.isEmpty()){
        try {
          insert historicalRatesToInsert;
        } catch (DmlException e) {
          System.debug('Error upserting current rates: ' + e.getMessage());
          throw new AuraHandledException('Error while inserting exchange rates. Please contact your administrator: ' + res.getStatus());
        }
      }
    } else {
        throw new AuraHandledException('Error fetching data from the API: ' + res.getStatus());
    }
  }

  //Retrieves the API URL from the custom metadata type API_Config__mdt.
  private static String getAPIUrl() {
    List<API_Config__mdt> configRecords = new List<API_Config__mdt>();

    configRecords = [
        SELECT MasterLabel, API_URL__c 
        FROM API_Config__mdt 
        WHERE DeveloperName = 'CoinGecko'
    ];
    
    if (configRecords.isEmpty()) {
      throw new AuraHandledException('API Config not found');
    }
    
    return configRecords[0].API_URL__c;
  }
}