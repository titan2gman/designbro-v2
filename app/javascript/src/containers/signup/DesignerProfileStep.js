import { compose } from 'redux'
import { connect } from 'react-redux'
import { withSpinner } from '@components/withSpinner'
import { withDesignerGuard } from '../../designerGuard'

import SignupDesignerProfileStep from '@components/signup/DesignerProfileStep'

const mapStateToProps = (state) => {
  return {
    inProgress: state.productCategories.inProgress
  }
}

export default compose(
  connect(mapStateToProps),
  withSpinner,
  withDesignerGuard
)(SignupDesignerProfileStep)
