import { connect } from 'react-redux'
import Dinero from 'dinero.js'
import { blindProjectPrice } from '@constants/prices'

import SummaryItem from '../SummaryItem'

const mapStateToProps = () => {
  return {
    name: 'Blind project',
    amount: Dinero({ amount: blindProjectPrice * 100 }).toFormat('$0,0.00'),
    isVisible: true,
    isFree: true
  }
}

export default connect(mapStateToProps)(SummaryItem)
