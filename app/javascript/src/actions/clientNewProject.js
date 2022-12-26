import api from '@utils/api'
import { validateStationery, isStationeryValid } from '../validators/projectStationeryStep'
import { validateCheckout, isCheckoutValid } from '../validators/projectCheckoutStep'
import { transformServerErrors } from '../validators/serverErrorsTransformer'

import {
  PROJECT_UPDATE_REQUEST,
  PROJECT_UPDATE_SUCCESS,
  PROJECT_UPDATE_FAILURE
} from './newProject'

const updateProject = (id, project, step, upgradeProjectState = true) => api.patch({
  endpoint: `/api/v1/public/projects/${id}`,
  body: { project, upgradeProjectState },

  types: [
    PROJECT_UPDATE_REQUEST,
    PROJECT_UPDATE_SUCCESS,
    PROJECT_UPDATE_FAILURE
  ]
})

export const CHANGE_PROJECT_DETAILS_ATTRIBUTE = 'CHANGE_PROJECT_DETAILS_ATTRIBUTE'
export const CHANGE_PROJECT_CHECKOUT_ATTRIBUTE = 'CHANGE_PROJECT_CHECKOUT_ATTRIBUTE'
export const CHANGE_PROJECT_STATIONERY_ATTRIBUTE = 'CHANGE_PROJECT_STATIONERY_ATTRIBUTE'

export const SET_STATIONERY_VALIDATION_ERRORS = 'SET_STATIONERY_VALIDATION_ERRORS'
export const SET_CHECKOUT_VALIDATION_ERRORS = 'SET_CHECKOUT_VALIDATION_ERRORS'
export const SET_CHECKOUT_VALIDATION_CREDIT_CARD_ERROR = 'SET_CHECKOUT_VALIDATION_CREDIT_CARD_ERROR'

export const changeProjectDetailsAttributes = (name, value) => ({
  type: CHANGE_PROJECT_DETAILS_ATTRIBUTE,
  name,
  value
})

export const changeProjectCheckoutAttributes = (name, value) => ({
  type: CHANGE_PROJECT_CHECKOUT_ATTRIBUTE,
  name,
  value
})

export const changeProjectStationeryAttributes = (name, value) => ({
  type: CHANGE_PROJECT_STATIONERY_ATTRIBUTE,
  name,
  value
})

export const updateProjectDetailsAttributes = () => (dispatch, getState) => {
  const project = getState().newProject.stepDetailsAttributes
  const id = getState().projects.current

  dispatch(updateProject(id, project, 'details', false))
}

export const saveProjectDetailsAttributes = (callback) => (dispatch, getState) => {
  const project = getState().newProject.stepDetailsAttributes
  const id = getState().projects.current

  dispatch(updateProject(id, project, 'details')).then((response) => {
    if (!response.error) {
      callback()
    }
  })
}

export const updateProjectCheckoutAttributes = () => (dispatch, getState) => {
  const project = getState().newProject.stepCheckoutAttributes
  const id = getState().projects.current

  dispatch(updateProject(id, project, 'checkout', false))
}

const setCheckoutValidationErrors = (payload) => ({
  type: SET_CHECKOUT_VALIDATION_ERRORS,
  payload
})

export const setCheckoutValidationCreditCardError = (payload) => ({
  type: SET_CHECKOUT_VALIDATION_CREDIT_CARD_ERROR,
  payload
})
// TODO: refactor
export const saveProjectCheckoutAttributes = (callback, stripe, btnCallback) => (dispatch, getState) => {
  const state = getState()
  const project = state.newProject.stepCheckoutAttributes
  const id = state.projects.current

  const validation = validateCheckout(state)

  if (isCheckoutValid(validation)) {
    dispatch(updateProject(id, project, 'checkout')).then((response) => {
      btnCallback && btnCallback()
      if (!response.error) {
        callback()
      } else {
        const errors = transformServerErrors(response.payload)

        if (errors) {
          // Stripe authentication via 3D secure
          if (errors['requiresAction']) {
            stripe.handleCardAction(errors['requiresAction'][0]).then(function(result) {
              if (result.error) {
                dispatch(setCheckoutValidationCreditCardError(result.error.message))
              } else {
                dispatch(changeProjectCheckoutAttributes('paymentIntentId', result.paymentIntent.id))

                const project = getState().newProject.stepCheckoutAttributes

                dispatch(updateProject(id, project, 'checkout')).then((response) => {
                  btnCallback && btnCallback()
                  if (!response.error) {
                    callback()
                  } else {
                    const errors = transformServerErrors(response.payload)

                    dispatch(setCheckoutValidationErrors(errors))
                  }
                })
              }
            })
          } else {
            dispatch(setCheckoutValidationErrors(errors))
          }
        }
      }
    })
  } else {
    dispatch(setCheckoutValidationErrors(validation))
  }
}

export const updateProjectStationeryAttributes = () => (dispatch, getState) => {
  const project = getState().newProject.stepStationeryAttributes
  const id = getState().projects.current

  dispatch(updateProject(id, project, 'stationery', false)).then((response) => {
    if (response.error) {
      const errors = transformServerErrors(response.payload)

      if (errors) {
        dispatch(setStationeryValidationErrors(errors))
      }
    }
  })
}

const setStationeryValidationErrors = (payload) => ({
  type: SET_STATIONERY_VALIDATION_ERRORS,
  payload
})

export const saveProjectStationeryAttributes = (callback) => (dispatch, getState) => {
  const project = getState().newProject.stepStationeryAttributes
  const state = getState()
  const id = state.projects.current

  const validation = validateStationery(state)

  if (isStationeryValid(validation)) {
    dispatch(updateProject(id, project, 'stationery')).then((response) => {
      if (!response.error) {
        callback()
      } else {
        const errors = transformServerErrors(response.payload)

        if (errors) {
          dispatch(setStationeryValidationErrors(errors))
        }
      }
    })
  } else {
    dispatch(setStationeryValidationErrors(validation))
  }
}
