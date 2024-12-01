// This class is responsible for managing cryptocurrency exchange rates. 
public with sharing class CryptoExchangeRate {

  //Retrieves the API URL from the custom metadata type API_Config__mdt.
  private static String getAPIUrl() {
    List<API_Config__mdt> configRecords = new List<API_Config__mdt>();

    //Ensures that the user has the necessary permissions to access the metadata.
    if (Schema.sObjectType.API_Config__mdt.isAccessible()) {
      configRecords = [
        SELECT MasterLabel, API_URL__c 
        FROM API_Config__mdt 
        WHERE DeveloperName = 'CoinGecko'
      ];
    } else {
      throw new AuraHandledException('User does not have permission to read API Config');
    }
    
    if (configRecords.isEmpty()) {
      throw new AuraHandledException('API Config not found');
    }
    
    return configRecords[0].API_URL__c;
  }
  // It fetches live rates from the external API and saves them into the custom Salesforce object Crypto_Rates__c. 
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
      List<Crypto_Rates__c> ratesToInsert = new List<Crypto_Rates__c>();

      for (String cryptoName : result.KeySet()) {
        Map<String, Object> cryptoData = (Map<String, Object>)result.get(cryptoName);
        Decimal cryptoRate = (Decimal)cryptoData.get(currencyCode);

        ratesToInsert.add(new Crypto_Rates__c(
          Name = cryptoName,
          Exchange_Rate__c = cryptoRate,
          Last_Updated__c = System.Now()
        ));
      }

      //Ensures that the user has the necessary permissions to access the metadata.
      if (Schema.sObjectType.Crypto_Rates__c.isCreateable()) {
        try {
          if (!ratesToInsert.isEmpty()) {
            insert ratesToInsert;
          }  
        } catch (DmlException e) {
          System.debug('Error inserting rates: ' + e.getMessage());
          throw new AuraHandledException('Error inserting data: ' + res.getStatus());
        }  
      } else {
        throw new AuraHandledException('User does not have permission to insert Crypto_Rates__c records.');
      }
    } else {
        throw new AuraHandledException('Error fetching data: ' + res.getStatus());
    }
  }
}