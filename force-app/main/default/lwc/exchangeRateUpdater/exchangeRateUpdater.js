import { LightningElement, wire } from 'lwc';
import getCryptoRates from '@salesforce/apex/CryptoRateService.getCryptoRates';

export default class ExchangeRateUpdater extends LightningElement {
    cryptoRates;

    @wire(getCryptoRates)
    wiredRates({ error, data }) {
        if (data) {
            // Задаем статичные значения для отображения
            this.cryptoRates = [
                { name: 'Bitcoin', rate: data.bitcoin.usd, currency: 'USD' },
                { name: 'Ethereum', rate: data.ethereum.usd, currency: 'USD' },
                { name: 'Tether', rate: data.tether.usd, currency: 'USD' },
                { name: 'Litecoin', rate: data.litecoin.usd, currency: 'USD' }
            ];
        } else if (error) {
            this.cryptoRates = [
                { name: 'Bitcoin', rate: 'Error', currency: 'USD' },
                { name: 'Ethereum', rate: 'Error', currency: 'USD' },
                { name: 'Tether', rate: 'Error', currency: 'USD' },
                { name: 'Litecoin', rate: 'Error', currency: 'USD' }
            ];
        }
    }
}
