# Automating Crypto-Currency Exchange Rates

## Introduction
This project automates the process of updating cryptocurrency exchange rates in Salesforce opportunities.

## Features
- Fetches current exchange rates via a public API.
- Allows administrators to refresh rates manually.
- Automatically updates Salesforce opportunity records with current exchange rates.

## Technical Overview
- **Frontend:** Lightning Web Components for admin interface.
- **Backend:** Apex for API calls and business logic.
- **Data Management:** Salesforce objects for storing exchange rates.

## Implementation
1. Integration with API using Apex.
2. Admin interface in LWC.
3. Automation using triggers/workflows.

## Testing Plan
- Unit tests for Apex classes.
- Manual UI tests for LWC.
