public class CryptoExchangeRateSchedulerSetup {
  public static void scheduleUpdater() {
    String cronExp = '0 0 0 * * ?';
    CryptoExchangeRateScheduler scheduler = new CryptoExchangeRateScheduler();
    System.schedule('Nightly Crypto Exchange Rate Update', cronExp, scheduler);
  }
}
