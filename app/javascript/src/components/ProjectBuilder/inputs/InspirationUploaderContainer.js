import { connect } from 'react-redux'

import {
  getProjectBuilderValidationErrors
} from '@selectors/projectBuilder'

import InspirationUploader from './InspirationUploader'

const mapStateToProps = (state, props) => {
  const errors = getProjectBuilderValidationErrors(state).inspirations

  return {
    errors: errors && errors[props.index] || {}
  }
}

export default connect(mapStateToProps)(InspirationUploader)
