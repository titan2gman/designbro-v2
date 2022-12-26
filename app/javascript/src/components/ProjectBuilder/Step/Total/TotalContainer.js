import { connect } from 'react-redux'
import { totalPriceWithVatSelector } from '@selectors/vat'

import Total from './Total'

const mapStateToProps = (state) => {
  const value = totalPriceWithVatSelector(state)

  return {
    value: value.toFormat('$0,0.00')
  }
}

export default connect(mapStateToProps)(Total)
