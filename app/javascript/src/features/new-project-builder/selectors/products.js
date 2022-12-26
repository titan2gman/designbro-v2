import _ from 'lodash'
import { projectSelector } from '@selectors/newProjectBuilder'
import { createSelector } from 'reselect'

export const productsSelector = (state) => state.newProjectBuilderProducts.products
export const productsLoadInProgressSelector = (state) => state.newProjectBuilderProducts.loadInProgress

export const productSelector = createSelector(
  projectSelector,
  (project) => {
    return _.get(project, ['product'], {})
  }
)

export const productByKeySelector = createSelector(
  productsSelector,
  (_, key) => key,
  (products, key) => {
    return _.find(products, { key })
  }
)

export const additionalDesignPricesSelector = createSelector(
  projectSelector,
  (project) => {
    return _.get(project, ['product', 'additionalDesignPrices'], [])
  }
)

export const additionalDesignPriceSelector = createSelector(
  additionalDesignPricesSelector,
  (_, spotsCount) => spotsCount,
  (prices, spotsCount) =>  _.get(_.find(prices, { quantity: spotsCount }), ['amount', 'cents'], 0)
)
