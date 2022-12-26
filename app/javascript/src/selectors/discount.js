import _ from 'lodash'
import { createSelector } from 'reselect'

export const discountsSelector = state => state.entities.discounts
export const currentDiscountValueSelector = state => state.projectBuilder.attributes.discountCode

export const currentDiscountSelector = createSelector(
  [discountsSelector, currentDiscountValueSelector],
  (discounts, discountCode) => {
    return _.find(discounts, (d) => d.code === discountCode)
  }
)

export const isCurrentDiscountValidSelector = createSelector(
  [currentDiscountSelector, currentDiscountValueSelector],
  (currentDiscount, discountCode) => {
    return currentDiscount && currentDiscount.available
  }
)
