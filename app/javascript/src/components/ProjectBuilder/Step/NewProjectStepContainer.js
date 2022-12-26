import { compose } from 'redux'
import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom'
import { withSpinner } from '@components/withSpinner'

import { isAuthenticated } from '@reducers/me'
import {
  getProjectBuilderStep,
  getProjectBuilderPreviousStep,
  projectBuilderStepSelector,
  getProjectBuilderStepQuestions,
  getProjectBuilderAttributes,
  getProjectBuilderValidationErrors
} from '@selectors/projectBuilder'
import { getCurrentProject } from '@selectors/projects'
import { getCurrentBrand } from '@selectors/brands'
import { totalPriceWithVatSelector } from '@selectors/vat'
import { currentProductSelector } from '@selectors/product'

import { submitStep } from '@actions/projectBuilder'

import NewProjectStep from './NewProjectStep'

const getRedirectPath = (id, currentStep, openStep) => {
  const shouldRedirect = currentStep && currentStep.position < openStep.position

  return shouldRedirect && `/projects/${id}/${currentStep.path}`
}

const getBackPath = (id, previousStep) => {
  return previousStep && `/projects/${id}/${previousStep.path}`
}

const mapStateToProps = (state, { match }) => {
  const inProgress = state.projectBuilder.inProgress

  if (inProgress) {
    return {
      inProgress
    }
  }

  const id = match.params.id
  const stepName = match.params.step

  const project = getCurrentProject(state)

  if (!project) {
    return {
      inProgress: true
    }
  }

  const currentStep = projectBuilderStepSelector(state)
  const openStep = getProjectBuilderStep(state, stepName)
  const previousStep = getProjectBuilderPreviousStep(state, openStep)
  const attributes = getCurrentProject(state)

  return {
    inProgress,
    attributes,
    redirectPath: getRedirectPath(id, currentStep, openStep),
    backPath: getBackPath(id, previousStep),
    openStep,
    questions: getProjectBuilderStepQuestions(state, openStep),
    isStepperVisible: !openStep.authenticationRequired,
    isSubmitPanelVisible: openStep.path !== 'checkout',
    hasPaidProject: getCurrentBrand(state).hasPaidProject,
    isContinueDisabled: openStep.path === 'finish' && !isAuthenticated(state),
    errors: getProjectBuilderValidationErrors(state),

    product: currentProductSelector(state),
    price: totalPriceWithVatSelector(state).toFormat('0,0.00'),
  }
}
export default compose(
  withRouter,
  connect(mapStateToProps, {
    submitStep
  }),
  withSpinner,
)(NewProjectStep)
