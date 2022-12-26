import { connect } from 'react-redux'

import SummaryItem from '../SummaryItem'

import { currentProjectAdditionalScreenPriceSelector } from '@selectors/prices'

const mapStateToProps = (state) => {
  const extraScreensPrice = currentProjectAdditionalScreenPriceSelector(state)

  return {
    isVisible: !extraScreensPrice.isZero(),
    amount: extraScreensPrice.toFormat('$0,0.00'),
    name: 'Additional Screens'
  }
}

export default connect(mapStateToProps)(SummaryItem)
