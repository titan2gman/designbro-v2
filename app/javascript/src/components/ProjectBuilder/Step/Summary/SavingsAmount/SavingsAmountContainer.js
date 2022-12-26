import { connect } from 'react-redux'

import SavingsAmount from './SavingsAmount'

import { savingsSelector } from '@selectors/prices'

const mapStateToProps = (state) => {
  const amount = savingsSelector(state)

  return {
    amount: amount.toFormat('$0,0.00')
  }
}

export default connect(mapStateToProps)(SavingsAmount)
