import { connect } from 'react-redux'

import SummaryItem from '../SummaryItem'

import { currentDiscountSelector } from '@selectors/discount'

const displayDiscountAmount = (discount) => {
  if (!discount) {
    return null
  }

  switch (discount.discountType) {
  case 'percent':
    return `${discount.value}%`
  case 'dollar':
    return `$${discount.value}`
  default:
    return null
  }
}

const mapStateToProps = (state) => {
  const discount = currentDiscountSelector(state)

  const discountAmount = displayDiscountAmount(discount)
  const isVisible = discount && discount.available

  return {
    name: 'Discount',
    amount: `- ${discountAmount}`,
    isVisible
  }
}

export default connect(mapStateToProps)(SummaryItem)
