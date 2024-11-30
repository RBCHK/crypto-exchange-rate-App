import { LightningElement, track } from 'lwc';

import getCryptoRates from '@salesforce/apex/CryptoExchangeRate.getCryptoRates';
import bitcoinIcon from '@salesforce/resourceUrl/bitcoinIcon';
import ethereumIcon from '@salesforce/resourceUrl/ethereumIcon';
import litecoinIcon from '@salesforce/resourceUrl/litecoinIcon';
import tetherIcon from '@salesforce/resourceUrl/tetherIcon';

export default class ExchangeRateUpdater extends LightningElement {
  bitcoinIconUrl = bitcoinIcon;
  ethereumIconUrl = ethereumIcon;
  tetherIconUrl = tetherIcon;
  litecoinIconUrl = litecoinIcon;
  
  // @track is used to track changes in the object/array for reactivity, 
  // required for compatibility with LWC versions before 45.
  @track rates = null;
  @track errorMessage = null;

  updateCryptoRates() {
    getCryptoRates()
    //.then(result => {
    //    this.rates = result;
    //    this.errorMessage = null;
    //  })
    //  .catch(error => {
    //    this.errorMessage = 'Error fetching exchange rates. Please try again later.';
    //    console.error('Error fetching exchange rates:', error);
    //  });
  }
}
