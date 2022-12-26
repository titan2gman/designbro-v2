import { connect } from 'react-redux'

import {
  getProjectBuilderValidationErrors
} from '@selectors/projectBuilder'

import ExistingDesignUploader from './ExistingDesignUploader'

const mapStateToProps = (state, props) => {
  const errors = getProjectBuilderValidationErrors(state).existingDesigns

  return {
    errors: errors && errors[props.index] || {}
  }
}

export default connect(mapStateToProps)(ExistingDesignUploader)
