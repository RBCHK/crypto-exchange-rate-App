public class CryptoExchangeRateScheduler implements Schedulable {
  public void execute(SchedulableContext context) {
    CryptoExchangeRate.getCryptoRates();
  }
}
