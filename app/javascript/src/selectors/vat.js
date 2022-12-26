import _ from 'lodash'
import { createSelector } from 'reselect'
import countries from 'country-list'
import values from 'lodash/values'
import { totalSelector } from './prices'

export const isNotIreland = (countryCode) => countryCode !== 'IE'

export const vatRatesSelector = (state) => state.entities.vatRates
export const currentCountryCodeSelector = (state) => state.projectBuilder.attributes.countryCode
export const currentVatNumberSelector = (state) => state.projectBuilder.attributes.vat
export const currentCompanyNameSelector = (state) => state.projectBuilder.attributes.companyName

export const getVatRates = (state) => (
  _.values(state.entities.vatRates)
)

export const currentCountryVatRateSelector = createSelector(
  [vatRatesSelector, currentCountryCodeSelector],
  (vatRates, countryCode) => {
    return _.find(vatRates, (v) => v.countryCode === countryCode)
  }
)

export const isEuropeanCountry = (state, countryCode) => (
  !_.isEmpty(getVatRates(state).filter((vatRate) => (
    vatRate.countryCode === countryCode
  )))
)

export const vatAmountVisibleSelector = createSelector(
  [currentCountryCodeSelector],
  (countryCode) => {
    return !!countryCode
  }
)

export const vatMultiplierSelector = createSelector(
  [vatAmountVisibleSelector, currentCountryVatRateSelector, currentVatNumberSelector, currentCompanyNameSelector],
  (isVisible, vatRate, vatNumber) => {
    if (isVisible && vatRate && !(isNotIreland(vatRate.countryCode) && vatNumber)) {
      return vatRate.percent / 100
    }

    return 0
  }
)

export const vatAmountSelector = createSelector(
  [totalSelector, vatMultiplierSelector],
  (totalPrice, vatMultiplier) => {
    return totalPrice.multiply(vatMultiplier)
  }
)

export const totalPriceWithVatSelector = createSelector(
  [totalSelector, vatAmountSelector],
  (totalPrice, vatAmount) => {
    return totalPrice.add(vatAmount)
  }
)
