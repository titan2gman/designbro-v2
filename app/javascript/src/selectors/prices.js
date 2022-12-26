import _ from 'lodash'
import { createSelector } from 'reselect'
import Dinero from 'dinero.js'

import { topDesignersPrice, blindProjectPrice } from '@constants/prices'

import { currentProductSelector, currentProductIdSelector } from './product'
import { currentDiscountSelector } from './discount'
import { getCurrentProject } from './projects'

const maxSpotsCountSelector = (state) => state.projectBuilder.attributes.maxSpotsCount
const upgradePackageSelector = (state) => state.projectBuilder.attributes.upgradePackage
const ndaTypeSelector = (state) => state.projectBuilder.attributes.ndaType
const ndaIsPaidSelector = (state) => state.projectBuilder.attributes.ndaIsPaid
const maxScreensCountSelector = (state) => state.projectBuilder.attributes.maxScreensCount

export const additionalDesignPricesSelector = (state) => state.entities.additionalDesignPrices
export const additionalScreenPricesSelector = (state) => state.entities.additionalScreenPrices
export const productsSelector = (state) => state.entities.products
export const ndaPricesSelector = (state) => state.entities.ndaPrices

export const productPriceSelector = (productKey) => (state) => {
  const obj = _.find(state.entities.products, product => product.key === productKey)
  return Dinero({ amount: obj.priceCents })
}

export const upgradePackagingPriceSelector = (state) => {
  return productPriceSelector('brand-identity')(state).subtract(
    productPriceSelector('logo')(state)
  )
}

export const currentProjectAdditionalDesignPricesSelector = createSelector(
  [additionalDesignPricesSelector, currentProductIdSelector],
  (prices, productId) => {
    return _.filter(prices, (price) => price.productId === productId)
  }
)

const currentProjectAdditionalScreenPricesSelector = createSelector(
  [additionalScreenPricesSelector, currentProductIdSelector],
  (prices, productId) => {
    return _.filter(prices, (price) => price.productId === productId)
  }
)

export const currentProjectAdditionalDesignPriceSelector = createSelector(
  [currentProjectAdditionalDesignPricesSelector, maxSpotsCountSelector],
  (prices, count) => {
    const price = _.find(prices, (price) => price.quantity === count)

    return Dinero({ amount: price && price.amountCents || 0 })
  }
)

export const currentProjectAdditionalScreenPriceSelector = createSelector(
  [currentProjectAdditionalScreenPricesSelector, maxScreensCountSelector],
  (prices, count) => {
    const price = _.find(prices, (price) => price.quantity === count)

    return Dinero({ amount: price && price.amountCents || 0 })
  }
)

export const standardNdaPriceSelector = createSelector(
  ndaPricesSelector,
  (prices) => {
    const priceObject = _.find(prices, (price) => price.ndaType === 'standard')

    return Dinero({ amount: priceObject.priceCents })
  }
)

export const customNdaPriceSelector = createSelector(
  ndaPricesSelector,
  (prices) => {
    const priceObject = _.find(prices, (price) => price.ndaType === 'custom')

    return Dinero({ amount: priceObject.priceCents })
  }
)

export const currentNdaFullPriceSelector = createSelector(
  [ndaPricesSelector, ndaTypeSelector],
  (prices, ndaType) => {
    return Dinero({ amount: _.find(prices, (price) => price.ndaType === ndaType).priceCents })
  }
)

export const currentNdaRealPriceSelector = createSelector(
  [ndaPricesSelector, ndaTypeSelector, ndaIsPaidSelector],
  (prices, ndaType, ndaIsPaid) => {
    if (['standard', 'custom'].includes(ndaType) && !ndaIsPaid) {
      return Dinero({ amount: _.get(_.find(prices, (price) => price.ndaType === ndaType), 'priceCents', 0) })
    }

    return Dinero({ amount: 0 })
  }
)

export const discountInDollars = (price, discount) => {
  if (discount) {
    switch (discount.discountType) {
    case 'percent':
      return price.multiply(discount.value / 100)
    case 'dollar':
      return Dinero({ amount: discount.value * 100 })
    default:
      return Dinero({ amount: 0 })
    }
  } else {
    return Dinero({ amount: 0 })
  }
}

export const totalPriceWithoutDiscountSelector = createSelector(
  [currentProductSelector, productsSelector, currentProjectAdditionalDesignPriceSelector, currentProjectAdditionalScreenPriceSelector, currentNdaRealPriceSelector, upgradePackageSelector, getCurrentProject],
  (currentProduct, products, additionalPrice, screensPrice, ndaPrice, upgradePackage, project) => {
    const priceKey = project.projectType == 'contest' ? 'priceCents' : 'oneToOnePriceCents'

    const productPriceCents = upgradePackage ?
      _.find(products, (product) => product.key === 'brand-identity')[priceKey] :
      currentProduct[priceKey]

    return Dinero({ amount: productPriceCents }).add(additionalPrice).add(screensPrice).add(ndaPrice)
  }
)

export const totalSelector = createSelector(
  [totalPriceWithoutDiscountSelector, currentDiscountSelector],
  (price, discount) => {
    return price.subtract(discountInDollars(price, discount))
  }
)

export const savingsSelector = createSelector(
  [totalPriceWithoutDiscountSelector, currentDiscountSelector],
  (price, discount) => {
    return discountInDollars(price, discount).add(
      Dinero({ amount: topDesignersPrice * 100 })
    ).add(
      Dinero({ amount: blindProjectPrice * 100 })
    )
  }
)
