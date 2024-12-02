import ExchangeRateUpdater from "c/exchangeRateUpdater";
import { createElement } from "lwc";

describe("c-exchange-rate-updater", () => {
  afterEach(() => {
    while (document.body.firstChild) {
      document.body.removeChild(document.body.firstChild);
    }
  });

  it("renders without crashing", () => {
    const element = createElement("c-exchange-rate-updater", {
      is: ExchangeRateUpdater
    });
    document.body.appendChild(element);

    expect(element).toBeTruthy();
  });
});
