import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom'
import { getProjectBuilderStep } from '@selectors/projectBuilder'

import Header from './Header'

const mapStateToProps = (state, { match }) => {
  const stepName = match.params.step
  const step = getProjectBuilderStep(state, stepName)

  return {
    name: step.name,
    description: step.description
  }
}

export default withRouter(connect(mapStateToProps)(Header))
