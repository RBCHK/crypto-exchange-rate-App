import { LightningElement, wire } from 'lwc';

import { refreshApex } from '@salesforce/apex';
import getCryptoRates from '@salesforce/apex/CryptoExchangeRate.getCryptoRates';
import getCurrentRates from '@salesforce/apex/CryptoRatesController.getCurrentRates';

import bitcoinIcon from '@salesforce/resourceUrl/bitcoinIcon';
import defaultLogo from '@salesforce/resourceUrl/default_logo';
import litecoinIcon from '@salesforce/resourceUrl/litecoinIcon';

export default class ExchangeRateUpdater extends LightningElement {
  icons = {
    default: defaultLogo,
    bitcoin: bitcoinIcon,
    litecoin: litecoinIcon
  };
  
  currentRates = [];
  wiredRates = [];
  errorMessage = null;
  isLoading = false;

  capitalizeWord(word) {
    if (!word) return word;
    return word.charAt(0).toUpperCase() + word.slice(1).toLowerCase();
  }

  @wire(getCurrentRates)
  wiredGetRates(value) {
    this.wiredRates = value
    
    const { data, error } = value

    if (data) {
      this.currentRates = data.map(obj => ({
        ...obj,
        name: this.capitalizeWord(obj.name),
        icon: this.icons[obj.name] || defaultLogo
      }));
      this.errorMessage = null;
    } else if (error) {
      this.errorMessage = error.body ? error.body.message : 'An error occurred while fetching the exchange rates.';
      this.currentRates = [];
    }
  }

  async updateCryptoRates() {
    this.isLoading = true;
    try {
      await getCryptoRates();
      await refreshApex(this.wiredRates);
    } catch (error) {
      this.errorMessage = error.body ? error.body.message : 'An error occurred while updating the exchange rates.';
    } finally {
    this.isLoading = false;
    }
  }
}
