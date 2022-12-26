import api from '@utils/api'
import { actions } from 'react-redux-form'
import { REQUIRED_GOOD_EXAMPLES_COUNT } from '@constants'
import { validateProductStep, isProductStepValid } from '../validators/projectProductStep'
import { transformServerErrors } from '../validators/serverErrorsTransformer'

import { history } from '../history'

export const incrementSkipAndCancelledExamplesIndex = () => ({
  type: 'INCREMENT_SKIP_AND_CANCELLED_EXAMPLES_INDEX'
})

export const PROJECT_LOAD_REQUEST = 'PROJECT_LOAD_REQUEST'
export const PROJECT_LOAD_SUCCESS = 'PROJECT_LOAD_SUCCESS'
export const PROJECT_LOAD_FAILURE = 'PROJECT_LOAD_FAILURE'

export const loadProject = (id) => api.get({
  endpoint: `/api/v1/projects/${id}`,
  normalize: true,

  types: [
    PROJECT_LOAD_REQUEST,
    PROJECT_LOAD_SUCCESS,
    PROJECT_LOAD_FAILURE
  ]
})

export const PROJECT_CREATE_REQUEST = 'PROJECT_CREATE_REQUEST'
export const PROJECT_CREATE_SUCCESS = 'PROJECT_CREATE_SUCCESS'
export const PROJECT_CREATE_FAILURE = 'PROJECT_CREATE_FAILURE'

export const SET_PRODUCT_VALIDATION_ERRORS = 'SET_PRODUCT_VALIDATION_ERRORS'

const setProductValidationErrors = (payload) => ({
  type: SET_PRODUCT_VALIDATION_ERRORS,
  payload
})

export const create = (project) => api.post({
  endpoint: '/api/v1/public/projects',
  normalize: true,
  body: { project },

  types: [
    PROJECT_CREATE_REQUEST,
    PROJECT_CREATE_SUCCESS,
    PROJECT_CREATE_FAILURE
  ]
})

export const createProject = (history) => (dispatch, getState) => {
  const state = getState()
  const project = state.newProject.stepProductAttributes

  const validation = validateProductStep(state)

  if (isProductStepValid(validation)) {
    dispatch(create(project)).then((response) => {
      if (response.error) {
        const errors = transformServerErrors(response.payload)

        if (errors) {
          dispatch(setProductValidationErrors(errors))
        }
      } else {
        const state = getState()

        const id = state.projects.current
        const project = state.entities.projects[id]
        const nextStep = state.entities.projectBuilderSteps[project.currentStep]

        history.push(`/projects/${id}/${nextStep.path}`)
      }
    })
  } else {
    dispatch(setProductValidationErrors(validation))
  }
}

export const PROJECT_UPDATE_REQUEST = 'PROJECT_UPDATE_REQUEST'
export const PROJECT_UPDATE_SUCCESS = 'PROJECT_UPDATE_SUCCESS'
export const PROJECT_UPDATE_FAILURE = 'PROJECT_UPDATE_FAILURE'

export const updateProjectBrandExamples = (id, openStep, project, upgradeProjectState = true) => api.patch({
  endpoint: `/api/v1/public/projects/${id}`,
  body: { project, upgradeProjectState, stepId: openStep.id },

  types: [
    PROJECT_UPDATE_REQUEST,
    PROJECT_UPDATE_SUCCESS,
    PROJECT_UPDATE_FAILURE
  ]
})

const removeExamplesFormError = () => actions.setValidity(
  'forms.newProjectExamplesStepParams',
  true
)

const generateMarkExampleAsFunction = (group) => (brandExampleId, openStep) => (dispatch, getState) => {
  dispatch({ type: `MARK_EXAMPLE_AS_${group.toUpperCase()}`, brandExampleId })

  const id = getState().projects.current
  const project = getState().newProject.examplesStep

  dispatch(updateProjectBrandExamples(id, openStep, project, false))
  dispatch(removeExamplesFormError())
}

export const markExampleAsBad = generateMarkExampleAsFunction('BAD')
export const markExampleAsGood = generateMarkExampleAsFunction('GOOD')
export const markExampleAsSkip = generateMarkExampleAsFunction('SKIP')
export const markExampleAsCancelled = generateMarkExampleAsFunction('CANCELLED')

export const PROJECT_DESTROY_REQUEST = 'PROJECT_DESTROY_REQUEST'
export const PROJECT_DESTROY_SUCCESS = 'PROJECT_DESTROY_SUCCESS'
export const PROJECT_DESTROY_FAILURE = 'PROJECT_DESTROY_FAILURE'

const destroyProject = (id) => api.delete({
  endpoint: `/api/v1/projects/${id}`,

  types: [
    PROJECT_DESTROY_REQUEST,
    PROJECT_DESTROY_SUCCESS,
    PROJECT_DESTROY_FAILURE
  ]
})

export const REMOVE_PROJECT_FROM_ENTITIES = 'REMOVE_PROJECT_FROM_ENTITIES'

const removeProjectFromEntities = (id) => ({
  type: REMOVE_PROJECT_FROM_ENTITIES,
  id,
})

export const deleteProject = (id) => (dispatch) => {
  dispatch(destroyProject(id)).then(() => {
    dispatch(removeProjectFromEntities(id))
  })
}

const updateProject = (id, project, step, upgradeProjectState = true) => api.patch({
  endpoint: `/api/v1/public/projects/${id}/${step}`,
  body: { project, upgradeProjectState },

  types: [
    PROJECT_UPDATE_REQUEST,
    PROJECT_UPDATE_SUCCESS,
    PROJECT_UPDATE_FAILURE
  ]
})

export const CHANGE_PROJECT_PRODUCT_ATTRIBUTE = 'CHANGE_PROJECT_PRODUCT_ATTRIBUTE'

export const changeProjectProductAttributes = (name, value) => ({
  type: CHANGE_PROJECT_PRODUCT_ATTRIBUTE,
  name,
  value
})
