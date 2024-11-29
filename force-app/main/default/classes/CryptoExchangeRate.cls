public class CryptoExchangeRate {
  public class CryptoRates {
      public Decimal bitcoin;
      public Decimal ethereum;
      public Decimal tether;
      public Decimal litecoin;
  }

  @AuraEnabled(cacheable=true)
  public static CryptoRates getCryptoRates() {
      String url = 'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin,ethereum,tether,litecoin&vs_currencies=usd';
      
      // Создаем HTTP запрос
      HttpRequest req = new HttpRequest();
      req.setEndpoint(url);
      req.setMethod('GET');
      
      // Отправляем запрос и получаем ответ
      Http http = new Http();
      HttpResponse res = http.send(req);
      
      CryptoRates rates = new CryptoRates();
      
      // Если запрос успешен, обрабатываем данные
      if (res.getStatusCode() == 200) {
          // Десериализуем JSON ответ в объект
          Map<String, Map<String, Decimal>> responseMap = (Map<String, Map<String, Decimal>>) JSON.deserializeUntyped(res.getBody());
          
          // Получаем курсы валют из объекта
          rates.bitcoin = responseMap.get('bitcoin').get('usd');
          rates.ethereum = responseMap.get('ethereum').get('usd');
          rates.tether = responseMap.get('tether').get('usd');
          rates.litecoin = responseMap.get('litecoin').get('usd');
      } else {
          System.debug('Error: ' + res.getStatusCode());
      }
      
      return rates;
  }
}
