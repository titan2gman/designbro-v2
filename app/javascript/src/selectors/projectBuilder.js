import _ from 'lodash'
import { createSelector } from 'reselect'
import { getCurrentProject } from './projects'

export const isProjectBuilderInProgress = (state) => state.projectBuilder.inProgress
export const getProjectBuilderAttributes = (state) => state.projectBuilder.attributes
export const getProjectBuilderUpsellAttributes = (state) => state.projectBuilder.upsell
export const getProjectBuilderValidationErrors = (state) => state.projectBuilder.validation

const getAllProjectBuilderSteps = state => state.entities.projectBuilderSteps
const getAllProjectBuilderQuestions = state => state.entities.projectBuilderQuestions

export const getProjectBuilderStep = (state, stepName) => {
  const currentProject = getCurrentProject(state)

  return _.find(getAllProjectBuilderSteps(state), {
    path: stepName,
    productId: currentProject.productId
  })
}

export const getProjectBuilderPreviousStep = (state, step) => {
  const currentProject = getCurrentProject(state)

  return _.find(getAllProjectBuilderSteps(state), {
    position: step.position - 1,
    productId: currentProject.productId
  })
}

export const projectBuilderStepsSelector = createSelector(
  [getCurrentProject, getAllProjectBuilderSteps],
  (currentProject, steps) => _.filter(steps, { productId: currentProject.productId })
)

export const projectBuilderStepsWithoutAuthSelector = createSelector(
  [projectBuilderStepsSelector],
  (steps) => _.filter(steps, { authenticationRequired: false })
)

export const projectBuilderStepSelector = createSelector(
  [getCurrentProject, getAllProjectBuilderSteps],
  (currentProject, steps) => {
    return _.find(steps, { id: currentProject.currentStep })
  }
)

export const getProjectBuilderStepQuestions = (state, openStep) => {
  return _.filter(getAllProjectBuilderQuestions(state), { projectBuilderStepId: parseInt(openStep.id) })
}
