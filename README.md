# Automating Crypto-Currency Exchange Rates

## Project Overview
This project provides a solution for automating cryptocurrency exchange rate management in Salesforce for **Global Containers Inc.**. It simplifies the process of fetching, storing, and applying exchange rates to sales opportunities, reducing manual work for Sales representatives.

## Features
- **API Integration**: Fetch real-time cryptocurrency exchange rates using a publicly available API.
- **Custom Interface**: Admin interface for refreshing exchange rates and managing API credentials.
- **Error Handling**: User-friendly error messages in case of API failures.
- **Automation**: Automatically updates exchange rates and applies them to sales opportunities.
- **Extendability**: Designed to scale with additional features like historical data retention and scheduled updates.

## Technologies
- **Apex**: Backend logic for API integration and data manipulation.
- **Lightning Web Components (LWC)**: Custom user interface.
- **Salesforce Metadata**: Storing API credentials and configurations.
- **Validation Rules**: Ensure data integrity during updates.

## How to Use
1. **Admin Setup**: Configure the API credentials in the custom admin interface.
2. **Fetch Exchange Rates**: Use the interface to fetch and update exchange rates.
3. **Opportunity Updates**: Rates are automatically applied to sales opportunities.

### Requirements
- **Store Current Exchange Rate**: Data is stored using Salesforce Metadata for easy retrieval and updates.
- **Admin Interface for Refreshing Rates**: Custom Lightning Web Component (LWC) for API interactions and refresh controls.
- **User-Friendly Error Handling**: Admins receive clear error messages for API failures, ensuring quick issue resolution.
- **Editable API Credentials**: Credentials and endpoints are stored in Salesforce Metadata, making it simple for admins to manage them.
- **Automatic Opportunity Updates**: Exchange rates are directly applied to related Opportunity records, streamlining the sales process.

## Roadmap (Nice-to-haves)
- **Nightly Schedule for Exchange Rate Updates**: Automated nightly updates using Salesforce Scheduled Apex.
- **Reactive Opportunity Updates**: Opportunities are updated automatically whenever exchange rate data changes.
- **Historical Exchange Rate Data**: Retains a history of past exchange rates for analytical purposes using a custom object.


## Contributions
This project is designed for demonstration purposes. Contributions are not accepted at this stage.
