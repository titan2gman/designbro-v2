import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom'
import {
  getProjectBuilderStep,
  projectBuilderStepsWithoutAuthSelector
} from '@selectors/projectBuilder'

import Stepper from './Stepper'

const mapStateToProps = (state, { match }) => {
  const stepName = match.params.step
  const step = getProjectBuilderStep(state, stepName)
  const steps = projectBuilderStepsWithoutAuthSelector(state)

  return {
    stepPosition: step.position,
    steps,
  }
}

export default withRouter(connect(mapStateToProps)(Stepper))
