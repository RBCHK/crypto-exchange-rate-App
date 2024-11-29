import { LightningElement, track } from 'lwc';

import getCryptoRates from '@salesforce/apex/CryptoExchangeRate.getCryptoRates';
import bitcoinIcon from '@salesforce/resourceUrl/bitcoinIcon';
import ethereumIcon from '@salesforce/resourceUrl/ethereumIcon';
import litecoinIcon from '@salesforce/resourceUrl/litecoinIcon';
import tetherIcon from '@salesforce/resourceUrl/tetherIcon';

export default class ExchangeRateUpdater extends LightningElement {
  bitcoinIconUrl = bitcoinIcon;
  ethereumIconUrl = ethereumIcon
  tetherIconUrl = tetherIcon
  litecoinIconUrl = litecoinIcon
  
  @track rates = {};
  @track error;

  connectedCallback() {
    this.fetchCryptoRates();
  }

  fetchCryptoRates() {
    getCryptoRates()
      .then(result => {
        this.rates = result;
        this.error = undefined;
      })
      .catch(error => {
        this.error = 'Error fetching data: ' + error.body.message;
        this.rates = {};
      });
  }
}
