public with sharing class CryptoExchangeRate {
  
  @AuraEnabled
  public static void getCryptoRates() {
    String url = 'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin,ethereum,tether,litecoin&vs_currencies=usd';
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