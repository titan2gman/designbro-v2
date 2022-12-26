import _ from 'lodash'
import { createSelector } from 'reselect'

import brandDnaQuestions from '@constants/brandDnaQuestions'
import audienceQuestions from '@constants/audienceQuestions'

export const projectSelector = (state) => state.newProjectBuilder.project
export const projectBrandExampleIdsSelector = (state) => state.newProjectBuilder.project.brandExampleIds
export const projectBuilderStepsSelector = (state) => state.newProjectBuilder.projectBuilderSteps

export const projectBrandDnaSelector = (state) => _.pick(state.newProjectBuilder.project, _.map(brandDnaQuestions, 'name'))
export const projectAudienceSelector = (state) => _.pick(state.newProjectBuilder.project, [..._.map(audienceQuestions, 'name'), 'brandDnaTargetCountryCodes'])

export const projectBuilderStepSelector = createSelector(
  projectBuilderStepsSelector,
  (_, path) => path,
  (steps, path) => {
    return steps.find(step => step.path === path)
  }
)

export const prevProjectBuilderStepSelector = createSelector(
  projectBuilderStepsSelector,
  (_, path) => path,
  (steps, path) => {
    const currentStepPosition = steps.find(step => step.path === path).position
    return steps.find(step => step.position === currentStepPosition - 1)
  }
)

export const nextProjectBuilderStepSelector = createSelector(
  projectBuilderStepsSelector,
  (_, path) => path,
  (steps, path) => {
    const currentStepPosition = steps.find(step => step.path === path).position
    return steps.find(step => step.position === currentStepPosition + 1)
  }
)

export const projectBuilderStepPercentageSelector = createSelector(
  projectBuilderStepsSelector,
  (_, stepPath) => stepPath,
  (steps, stepPath) => {
    if (!stepPath || !steps || !steps.length) {
      return 0
    }

    const step = steps.find(step => step.path === stepPath)

    return step.position * 100 / (steps.length - 2)
  }
)
