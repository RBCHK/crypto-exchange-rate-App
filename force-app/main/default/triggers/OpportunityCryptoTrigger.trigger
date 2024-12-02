trigger OpportunityCryptoTrigger on Opportunity (before insert, before update) {
  CryptoRateService.applyCryptoExchangeRate(Trigger.new);
}