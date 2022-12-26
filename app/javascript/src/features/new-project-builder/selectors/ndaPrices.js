import _ from 'lodash'
import { createSelector } from 'reselect'

export const ndaPricesSelector = (state) => state.newProjectBuilderNdaPrices.ndaPrices
export const ndaPricesLoadInProgressSelector = (state) => state.newProjectBuilderNdaPrices.loadInProgress

export const ndaPriceSelector = createSelector(
  ndaPricesSelector,
  (_, ndaType) => ndaType,
  (prices, ndaType) =>  _.get(_.find(prices, { ndaType }), ['price', 'cents'], 0)
)
