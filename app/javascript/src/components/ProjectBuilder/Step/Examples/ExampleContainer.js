import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom'

import { markExampleAsCancelled } from '@actions/newProject'

import Example from './Example'
import { getProjectBuilderStep } from '@selectors/projectBuilder'

const mapStateToProps = (state, { match }) => {
  const stepName = match.params.step
  const openStep = getProjectBuilderStep(state, stepName)

  return {
    openStep
  }
}

export default withRouter(connect(mapStateToProps, {
  markExampleAsCancelled
})(Example))
