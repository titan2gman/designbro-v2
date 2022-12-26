import { connect } from 'react-redux'

import SummaryItem from '../SummaryItem'
import { currentNdaFullPriceSelector } from '@selectors/prices'
import { getProjectBuilderAttributes } from '@selectors/projectBuilder'
import { humanizeNdaTypeName } from '@utils/humanizer'

const mapStateToProps = (state) => {
  const attributes = getProjectBuilderAttributes(state)
  const { ndaType, ndaIsPaid } = attributes

  const isVisible = ['standard', 'custom'].includes(ndaType)

  const amount = currentNdaFullPriceSelector(state).toFormat('$0,0.00')

  return {
    name: humanizeNdaTypeName(ndaType),
    isVisible,
    isFree: ndaIsPaid,
    amount
  }
}

export default connect(mapStateToProps)(SummaryItem)
