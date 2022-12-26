import { connect } from 'react-redux'

import { vatAmountSelector, vatAmountVisibleSelector } from '@selectors/vat'

import SummaryItem from '../SummaryItem'

const mapStateToProps = (state) => {
  const amount = vatAmountSelector(state)

  return {
    name: 'VAT',
    amount: amount.toFormat('$0,0.00'),
    isVisible: vatAmountVisibleSelector(state)
  }
}

export default connect(mapStateToProps)(SummaryItem)
