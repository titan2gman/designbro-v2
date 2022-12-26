import { compose } from 'redux'
import { connect } from 'react-redux'
import { withSpinner } from '@components/withSpinner'
import { withDesignerGuard } from '../../designerGuard'

import SignupDesignerPortfolioStep from '@components/signup/DesignerPortfolioStep'

const mapStateToProps = (state) => {
  return {
    inProgress: state.productCategories.inProgress
  }
}

export default compose(
  connect(mapStateToProps),
  withSpinner,
  withDesignerGuard
)(SignupDesignerPortfolioStep)
