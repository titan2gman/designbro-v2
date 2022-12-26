import { connect } from 'react-redux'

import SummaryItem from '../SummaryItem'

import { currentProjectAdditionalDesignPriceSelector } from '@selectors/prices'

const mapStateToProps = (state) => {
  const extraDesignsPrice = currentProjectAdditionalDesignPriceSelector(state)

  return {
    isVisible: !extraDesignsPrice.isZero(),
    amount: extraDesignsPrice.toFormat('$0,0.00'),
    name: 'Extra designs'
  }
}

export default connect(mapStateToProps)(SummaryItem)
