@isTest
public class CryptoRatesControllerTest {
  @isTest
  static void testGetCurrentRates() {
    Current_Exchange_Rates__c rate1 = new Current_Exchange_Rates__c(
      Name = 'bitcoin',
      Current_Exchange_Rate__c = 95662,
      Last_Updated__c = System.now()
    );
    insert rate1;

    Current_Exchange_Rates__c rate2 = new Current_Exchange_Rates__c(
      Name = 'ripple',
      Current_Exchange_Rate__c = 2.70,
      Last_Updated__c = System.now()
    );
    insert rate2;

    Test.startTest();
    List<Map<String, Object>> rates = CryptoRatesController.getCurrentRates();
    Test.stopTest();

    System.assertNotEquals(rates, null, 'Rates should not be null');
    System.assertEquals(rates.size(), 2, 'There should be 2 rates returned');
    System.assertEquals(
      rates[0].get('name'),
      'bitcoin',
      'The name should match'
    );
    System.assertEquals(
      rates[1].get('name'),
      'ripple',
      'The name should match'
    );
    System.assertEquals(rates[0].get('rate'), 95662, 'The rate should match');
    System.assertEquals(rates[0].get('rate'), 2.70, 'The rate should match');
  }
}
