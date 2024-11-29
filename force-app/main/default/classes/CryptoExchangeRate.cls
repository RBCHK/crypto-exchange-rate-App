public class CryptoExchangeRate {
  @AuraEnabled(cacheable=true)
  public static Map<String, Decimal> getCryptoRates() {
      
      String url = 'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin,ethereum,tether,litecoin&vs_currencies=usd';
      
      HttpRequest req = new HttpRequest();
      req.setEndpoint(url);
      req.setMethod('GET');
      req.setHeader('Content-Type', 'application/json');
      
      Http http = new Http();
      HttpResponse res = http.send(req);
      
      if (res.getStatusCode() == 200) {
          String responseBody = res.getBody();
          
          Map<String, Object> data = (Map<String, Object>) JSON.deserializeUntyped(responseBody);
          Map<String, Decimal> rates = new Map<String, Decimal>();
          
          if (data.containsKey('bitcoin')) {
              rates.put('Bitcoin', (Decimal)((Map<String, Object>)data.get('bitcoin')).get('usd'));
          }
          if (data.containsKey('ethereum')) {
              rates.put('Ethereum', (Decimal)((Map<String, Object>)data.get('ethereum')).get('usd'));
          }
          if (data.containsKey('tether')) {
              rates.put('Tether', (Decimal)((Map<String, Object>)data.get('tether')).get('usd'));
          }
          if (data.containsKey('litecoin')) {
              rates.put('Litecoin', (Decimal)((Map<String, Object>)data.get('litecoin')).get('usd'));
          }
          
          return rates;
      } else {
          throw new AuraHandledException('Error fetching data: ' + res.getStatus());
      }
  }
}
