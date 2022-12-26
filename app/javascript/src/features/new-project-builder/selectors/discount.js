import Dinero from 'dinero.js'
import { createSelector } from 'reselect'
import { projectSelector } from '@selectors/newProjectBuilder'

export const discountSelector = (state) => state.newProjectBuilderDiscount.discount || projectSelector(state).discount
export const discountLoadInProgressSelector = (state) => state.newProjectBuilderDiscount.loadInProgress

export const discountAmountSelector = createSelector(
  discountSelector,
  (_, total) => total,
  (discount, total) => {
    if (discount) {
      switch (discount.discountType) {
      case 'percent':
        return total.multiply(discount.value / 100)
      case 'dollar':
        return Dinero({ amount: discount.value * 100 })
      default:
        return Dinero({ amount: 0 })
      }
    } else {
      return Dinero({ amount: 0 })
    }
  }
)
