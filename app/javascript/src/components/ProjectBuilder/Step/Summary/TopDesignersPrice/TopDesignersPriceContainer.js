import { connect } from 'react-redux'
import Dinero from 'dinero.js'
import { topDesignersPrice } from '@constants/prices'

import SummaryItem from '../SummaryItem'

const mapStateToProps = () => {
  return {
    name: 'Top designers',
    amount: Dinero({ amount: topDesignersPrice * 100 }).toFormat('$0,0.00'),
    isVisible: true,
    isFree: true
  }
}

export default connect(mapStateToProps)(SummaryItem)
