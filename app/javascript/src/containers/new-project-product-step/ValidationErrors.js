import { connect } from 'react-redux'
import _ from 'lodash'

import ValidationErrors from '@components/new-project-product-step/ValidationErrors'

const mapStateToProps = (state) => {
  return {
    errors: state.validations.newProjectProductStepErrors
  }
}

export default connect(mapStateToProps)(ValidationErrors)
