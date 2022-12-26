import _ from 'lodash'
import { createSelector } from 'reselect'

export const isIreland = (countryCode) => countryCode === 'IE'

export const vatRatesSelector = (state) => state.newProjectBuilderVatRates.vatRates
export const vatRatesLoadInProgressSelector = (state) => state.newProjectBuilderVatRates.loadInProgress

export const vatRatesCountriesSelector = createSelector(
  vatRatesSelector,
  (rates) => _.map(rates, rate => rate.countryCode)
)

export const vatRateSelector = createSelector(
  vatRatesSelector,
  (_, countryCode) => countryCode,
  (rates, countryCode) =>  _.get(_.find(rates, { countryCode }), ['percent'], 0)
)

export const isEuropeanCountry = createSelector(
  vatRatesCountriesSelector,
  (_, countryCode) => countryCode,
  (countries, countryCode) => countries.includes(countryCode)
)
