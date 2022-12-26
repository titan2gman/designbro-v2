import { connect } from 'react-redux'

import {
  getProjectBuilderValidationErrors
} from '@selectors/projectBuilder'

import StockImageUploader from './StockImageUploader'

const mapStateToProps = (state, props) => {
  const errors = getProjectBuilderValidationErrors(state).projectStockImages

  return {
    errors: errors && errors[props.index] || {}
  }
}

export default connect(mapStateToProps)(StockImageUploader)
