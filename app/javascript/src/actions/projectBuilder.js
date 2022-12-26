import _ from 'lodash'
import api from '@utils/api'
import { history } from '../history'
import stripe from '../stripe'

import { validateStep } from '../validators/projectBuilder'

import { transformServerErrors } from '../validators/serverErrorsTransformer'

import {
  projectBuilderStepSelector,
  projectBuilderStepsSelector,
  getProjectBuilderStepQuestions,
  getProjectBuilderAttributes
} from '../selectors/projectBuilder'

import { currentProductKeySelector, currentProductSelector } from '../selectors/product'
import { totalPriceWithVatSelector } from '@selectors/vat'

import camelCase from 'lodash/camelCase'

import { hideModal, showPaymentModal, showGetQuoteModal } from './modal'
import { saveGAPurchaseEvent } from '../utils/googleAnalytics'

import {
  examplesStep,
  detailsStep,
  checkoutStep,
  packagingTypeStep,
  colorsQuestion,
  competitorsQuestion,
  existingDesignsQuestion,
  existingLogosQuestion,
  inspirationsQuestion,
  additionalDocumentsQuestion,
  stockImagesQuestion,
  brandSelectorQuestion,
  optionalBrandSelectorQuestion,

  stepHasQuestion,
  getStepQuestions,
  getStepAttributeNames
} from '../utils/projectBuilder'


export const PROJECT_LOAD_REQUEST = 'PROJECT_LOAD_REQUEST'
export const PROJECT_LOAD_SUCCESS = 'PROJECT_LOAD_SUCCESS'
export const PROJECT_LOAD_FAILURE = 'PROJECT_LOAD_FAILURE'

export const loadProject = (id) => api.get({
  endpoint: `/api/v1/public/projects/${id}`,
  normalize: true,

  types: [
    PROJECT_LOAD_REQUEST,
    PROJECT_LOAD_SUCCESS,
    PROJECT_LOAD_FAILURE
  ]
})

export const CHANGE_PROJECT_BUILDER_ATTRIBUTES = 'CHANGE_PROJECT_BUILDER_ATTRIBUTES'

export const changeAttributes = (data) => ({
  type: CHANGE_PROJECT_BUILDER_ATTRIBUTES,
  payload: data
})

export const CHANGE_PROJECT_UPSELL_ATTRIBUTES = 'CHANGE_PROJECT_UPSELL_ATTRIBUTES'

export const changeUpsellAttributes = (data) => ({
  type: CHANGE_PROJECT_UPSELL_ATTRIBUTES,
  payload: data
})

const getUpdateProjectUrl = (id, openStep) => {
  // const pathPrefix = openStep.authenticationRequired ? '' : '/public'
  const pathPrefix = '/public'

  return `/api/v1${pathPrefix}/projects/${id}`
}

export const PROJECT_UPDATE_REQUEST = 'PROJECT_UPDATE_REQUEST'
export const PROJECT_UPDATE_SUCCESS = 'PROJECT_UPDATE_SUCCESS'
export const PROJECT_UPDATE_FAILURE = 'PROJECT_UPDATE_FAILURE'

const updateProject = (id, openStep, project, upgradeProjectState = false) => api.patch({
  endpoint: getUpdateProjectUrl(id, openStep),
  body: { project, upgradeProjectState, stepId: openStep.id },
  normalize: true,

  types: [
    PROJECT_UPDATE_REQUEST,
    PROJECT_UPDATE_SUCCESS,
    PROJECT_UPDATE_FAILURE
  ]
})

export const PROJECT_UPSELL_REQUEST = 'PROJECT_UPSELL_REQUEST'
export const PROJECT_UPSELL_SUCCESS = 'PROJECT_UPSELL_SUCCESS'
export const PROJECT_UPSELL_FAILURE = 'PROJECT_UPSELL_FAILURE'

const upsellProjectSpots = (id, project) => api.post({
  endpoint: `/api/v1/projects/${id}/upsell_spots`,
  body: { project },
  normalize: true,

  types: [
    PROJECT_UPSELL_REQUEST,
    PROJECT_UPSELL_SUCCESS,
    PROJECT_UPSELL_FAILURE
  ]
})

const upsellProjectDays = (id, project) => api.post({
  endpoint: `/api/v1/projects/${id}/upsell_days`,
  body: { project },
  normalize: true,

  types: [
    PROJECT_UPSELL_REQUEST,
    PROJECT_UPSELL_SUCCESS,
    PROJECT_UPSELL_FAILURE
  ]
})

export const SET_PROJECT_BUILDER_VALIDATION_ERRORS = 'SET_PROJECT_BUILDER_VALIDATION_ERRORS'

export const setStepValidationErrors = (validation) => {
  return {
    type: SET_PROJECT_BUILDER_VALIDATION_ERRORS,
    payload: validation
  }
}

const getNextStep = (steps, openStep) => {
  return _.find(steps, { position: openStep.position + 1 })
}

const getNextStepUrl = (nextStep, id, productKey) => {
  if (!nextStep) {
    return `/projects/${id}/success?product=${productKey}`
  }

  return `/projects/${id}/${nextStep.path}`
}

const uploadedFileIdDefinedFilter = ({ uploadedFileId }) => !!uploadedFileId

const detailsStepAttributes = ['ndaType', 'ndaValue', 'upgradePackage', 'maxSpotsCount', 'maxScreensCount', 'discountCode']
const checkoutStepAttributes = ['firstName', 'lastName', 'countryCode', 'companyName', 'vat', 'paymentType', 'paypalPaymentId', 'paymentIntentId', 'paymentMethodId']

const getProjectData = (state, openStep) => {
  const questions = getProjectBuilderStepQuestions(state, openStep)

  if (stepHasQuestion(questions, packagingTypeStep)) {
    const packagingType = state.forms.newProjectPackagingType.packagingType
    const measurementsKey = `${camelCase(state.forms.newProjectPackagingType.packagingType)}Measurements`
    return { packagingType, ...state.forms.newProjectPackagingType[measurementsKey] }
  }

  if (stepHasQuestion(questions, examplesStep)) {
    return state.newProject.examplesStep
  }

  if (stepHasQuestion(questions, detailsStep)) {
    return _.pick(state.projectBuilder.attributes, detailsStepAttributes)
  }

  if (stepHasQuestion(questions, checkoutStep)) {
    return _.pick(state.projectBuilder.attributes, checkoutStepAttributes)
  }

  const stepAttributeNames = getStepAttributeNames(questions, openStep)

  let data = _.pick(state.projectBuilder.attributes, stepAttributeNames)

  if (stepHasQuestion(questions, colorsQuestion)) {
    const colorsData = _.pick(state.projectBuilder.attributes, ['colors', 'colorsComment'])

    data = {
      ...data,
      ...colorsData,
      colorsExist: state.projectBuilder.attributes.colorsExist === 'yes'
    }
  }

  if (stepHasQuestion(questions, competitorsQuestion)) {
    data = {
      ...data,
      competitorsExist: state.projectBuilder.attributes.competitorsExist === 'yes',
      competitors: _.filter(state.projectBuilder.attributes.competitors, uploadedFileIdDefinedFilter)
    }
  }

  if (stepHasQuestion(questions, existingDesignsQuestion) || stepHasQuestion(questions, existingLogosQuestion)) {
    data = {
      ...data,
      sourceFilesShared: state.projectBuilder.attributes.sourceFilesShared === 'yes',
      existingDesignsExist: state.projectBuilder.attributes.existingDesignsExist === 'yes',
      existingDesigns: _.filter(state.projectBuilder.attributes.existingDesigns, uploadedFileIdDefinedFilter)
    }
  }

  if (stepHasQuestion(questions, inspirationsQuestion)) {
    data = {
      ...data,
      inspirationsExist: state.projectBuilder.attributes.inspirationsExist === 'yes',
      inspirations: _.filter(state.projectBuilder.attributes.inspirations, uploadedFileIdDefinedFilter)
    }
  }

  if (stepHasQuestion(questions, additionalDocumentsQuestion)) {
    data = {
      ...data,
      additionalDocuments: _.filter(state.projectBuilder.attributes.projectAdditionalDocuments, uploadedFileIdDefinedFilter)
    }
  }

  if (stepHasQuestion(questions, stockImagesQuestion)) {
    data = {
      ...data,
      stockImagesExist: state.projectBuilder.attributes.stockImagesExist,
      stockImages: _.filter(state.projectBuilder.attributes.projectStockImages, uploadedFileIdDefinedFilter)
    }
  }

  if (stepHasQuestion(questions, brandSelectorQuestion) || stepHasQuestion(questions, optionalBrandSelectorQuestion)) {
    data = {
      ...data,
      brandName: state.projectBuilder.attributes.brandName,
      brandId: state.projectBuilder.attributes.brandId
    }
  }

  return data
}

export const submitStep = (openStep) => (dispatch, getState) => {
  const state = getState()
  const id = state.projects.current
  const steps = projectBuilderStepsSelector(state)

  const [isValid, validation] = validateStep(openStep, state)

  if (isValid) {
    const data = getProjectData(state, openStep)

    return dispatch(updateProject(id, openStep, data, true)).then((response) => {
      if (response.error) {
        const errors = transformServerErrors(response.payload)

        if (errors) {
          // Stripe authentication via 3D secure
          if (errors['requiresAction']) {
            stripe.handleCardAction(errors['requiresAction'][0]).then(function(result) {
              if (result.error) {
                // dispatch(setCheckoutValidationCreditCardError(result.error.message))
                // TODO
              } else {
                dispatch(changeAttributes({ paymentIntentId: result.paymentIntent.id }))

                const state = getState()
                const data = getProjectData(state, openStep)

                dispatch(submitStep(openStep))
              }
            })
          } else {
            dispatch(setStepValidationErrors(errors))
          }
        }
      } else {
        const state = getState()

        const id = state.projects.current
        const project = state.entities.projects[id]
        const productKey = currentProductKeySelector(state)
        const nextStep = state.entities.projectBuilderSteps[project.currentStep]

        const nextStepUrl = getNextStepUrl(nextStep, id, productKey)

        if (!nextStep) {
          saveGAPurchaseEvent({
            product: currentProductSelector(state),
            id: state.projects.current,
            price: totalPriceWithVatSelector(state).toFormat('0,0.00'),
          })
        }

        history.push(nextStepUrl)
      }
    })
  } else {
    return dispatch(setStepValidationErrors(validation))
  }
}

export const saveStep = (openStep) => (dispatch, getState) => {
  const state = getState()
  const id = state.projects.current
  const steps = projectBuilderStepsSelector(state)
  const data = getProjectData(state, openStep)

  dispatch(updateProject(id, openStep, data))
}



// TODO: rewrite to changeAttributes

export const SET_PROJECT_COLOR_BY_INDEX = 'SET_PROJECT_COLOR_BY_INDEX'
export const REMOVE_PROJECT_COLOR_BY_INDEX = 'REMOVE_PROJECT_COLOR_BY_INDEX'

export const setProjectColorByIndex = (index, { hex }) => ({
  type: SET_PROJECT_COLOR_BY_INDEX, index, color: hex
})

export const removeProjectColorByIndex = (index) => ({
  type: REMOVE_PROJECT_COLOR_BY_INDEX, index
})

export const PROJECT_CREATE_REQUEST = 'PROJECT_CREATE_REQUEST'
export const PROJECT_CREATE_SUCCESS = 'PROJECT_CREATE_SUCCESS'
export const PROJECT_CREATE_FAILURE = 'PROJECT_CREATE_FAILURE'

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

const getCreateContestProjectData = (state) => {
  const attributes = getProjectBuilderAttributes(state)

  return _.pick(attributes, ['brandId', 'brandName', 'productId', 'projectType', 'designerId'])
}

const getCreateOneToOneProjectData = (state) => {
  const attributes = getProjectBuilderAttributes(state)

  return _.pick(attributes, [
    'brandId', 'brandName', 'productId', 'projectType', 'designerId',
    'paymentType',
    'discountCode',
    'paypalPaymentId', // paypal
    'paymentIntentId', 'paymentMethodId' // stripe
  ])
}

const resetProjectBuilderAttributes = () => {
  return changeAttributes({
    productId: null,
    projectType: null,
    designerId: null,
    paypalPaymentId: null,
    paymentIntentId: null,
    paymentMethodId: null
  })
}

export const RESET_PROJECT_UPSELL_ATTRIBUTES = 'RESET_PROJECT_UPSELL_ATTRIBUTES'
const resetProjectUpsellAttributes = () => ({
  type: RESET_PROJECT_UPSELL_ATTRIBUTES
})

export const createOneToOneProject = () => (dispatch, getState) => {
  const state = getState()
  const data = getCreateOneToOneProjectData(state)

  return dispatch(create(data)).then((response) => {
    if (!response.error) {
      const state = getState()

      const id = state.projects.current
      const project = state.entities.projects[id]
      const nextStep = state.entities.projectBuilderSteps[project.currentStep]

      history.push(`/projects/${id}/${nextStep.path}`)

      dispatch(hideModal())
      dispatch(resetProjectBuilderAttributes())
    } else {
      const errors = transformServerErrors(response.payload)

      if (errors) {
        // Stripe authentication via 3D secure
        if (errors['requiresAction']) {
          stripe.handleCardAction(errors['requiresAction'][0]).then(function(result) {
            if (result.error) {
              // dispatch(setCheckoutValidationCreditCardError(result.error.message))
              // TODO
            } else {
              dispatch(changeAttributes({ paymentIntentId: result.paymentIntent.id }))

              const state = getState()
              const data = getCreateOneToOneProjectData(state)

              dispatch(createOneToOneProject())
            }
          })
        } else {
          dispatch(setStepValidationErrors(errors))
        }
      }
    }
  })
}

export const createContestProject = () => (dispatch, getState) => {
  const params = new URLSearchParams(document.location.search)
  const designerId = params.get('designer_id')

  if (designerId) {
    dispatch(changeAttributes({
      designerId
    }))
  }

  const state = getState()
  const data = getCreateContestProjectData(state)

  dispatch(create(data)).then((response) => {
    if (response.error) {
      // TODO
    } else {
      const state = getState()

      const id = state.projects.current
      const project = state.entities.projects[id]
      const nextStep = state.entities.projectBuilderSteps[project.currentStep]

      dispatch(resetProjectBuilderAttributes())

      history.push(`/projects/${id}/${nextStep.path}`)
    }
  })
}

export const finishProductStep = (e) => (dispatch, getState) => {
  const state = getState()
  const attributes = getProjectBuilderAttributes(state)

  if (attributes.productId === 'manual') {
    dispatch(showGetQuoteModal())
  } else if (attributes.projectType === 'one_to_one') {
    dispatch(showPaymentModal())
  } else {
    dispatch(createContestProject())
  }
}

export const createProjectWithPaypalPayment = (paymentDetails) => (dispatch, getState) => {
  dispatch(changeAttributes({ paypalPaymentId: paymentDetails.id }))

  return dispatch(createOneToOneProject())
}

export const createProjectWithStripePayment = (paymentDetails) => (dispatch, getState) => {
  if (paymentDetails) {
    dispatch(changeAttributes({ paymentMethodId: paymentDetails.id }))
  }

  return dispatch(createOneToOneProject())
}

export const updateProjectWithPaypalPayment = (openStep, paymentDetails) => (dispatch, getState) => {
  dispatch(changeAttributes({ paypalPaymentId: paymentDetails.id }))

  return dispatch(submitStep(openStep))
}

export const updateProjectWithStripePayment = (openStep, paymentDetails) => (dispatch, getState) => {
  if (paymentDetails) {
    dispatch(changeAttributes({ paymentMethodId: paymentDetails.id }))
  }

  return dispatch(submitStep(openStep))
}

export const buySpotsUpsellWithPaypalPayment = (paymentDetails) => (dispatch, getState) => {
  dispatch(changeAttributes({ paypalPaymentId: paymentDetails.id }))

  return dispatch(buySpotsUpsell())
}

export const buySpotsUpsellWithStripePayment = (paymentDetails) => (dispatch, getState) => {
  if (paymentDetails) {
    dispatch(changeAttributes({ paymentMethodId: paymentDetails.id }))
  }

  return dispatch(buySpotsUpsell())
}

export const buyDaysUpsellWithPaypalPayment = (project) => (dispatch, getState) => (paymentDetails) => {
  dispatch(changeAttributes({ paypalPaymentId: paymentDetails.id }))

  return dispatch(buyDaysUpsell(project))
}

export const buyDaysUpsellWithStripePayment = (project) => (dispatch, getState) => (paymentDetails) => {
  if (paymentDetails) {
    dispatch(changeAttributes({ paymentMethodId: paymentDetails.id }))
  }

  return dispatch(buyDaysUpsell(project))
}

export const closeExistingLogoModal = () => (dispatch, getState) => {
  dispatch(changeAttributes({ existingDesignsExist: 'yes' }))
  dispatch(hideModal())
}

export const requestManualProject = (content) => api.post({
  endpoint: '/api/v1/projects/manual_request',
  body: { content },

  types: [
    'PROJECT_MANUAL_REQUEST',
    'PROJECT_MANUAL_SUCCESS',
    'PROJECT_MANUAL_FAILURE'
  ]
})

export const buySpotsUpsell = () => (dispatch, getState) => {
  const state = getState()
  const id = state.projects.current
  const { numberOfSpots } = state.projectBuilder.upsell
  const { paymentType, paypalPaymentId, paymentIntentId, paymentMethodId, discountCode } = state.projectBuilder.attributes
  const data = { numberOfSpots, paymentType, paypalPaymentId, paymentIntentId, paymentMethodId, discountCode }

  return dispatch(upsellProjectSpots(id, data)).then((response) => {
    if (!response.error) {
      const state = getState()

      dispatch(hideModal())
      dispatch(resetProjectUpsellAttributes())
    } else {
      const errors = transformServerErrors(response.payload)

      if (errors) {
        // Stripe authentication via 3D secure
        if (errors['requiresAction']) {
          stripe.handleCardAction(errors['requiresAction'][0]).then(function(result) {
            if (result.error) {
              // dispatch(setCheckoutValidationCreditCardError(result.error.message))
              // TODO
            } else {
              dispatch(changeAttributes({ paymentIntentId: result.paymentIntent.id }))

              const state = getState()
              const data = getCreateOneToOneProjectData(state)

              dispatch(buySpotsUpsell())
            }
          })
        } else {
          dispatch(setStepValidationErrors(errors))
        }
      }
    }
  })
}

export const buyDaysUpsell = (project) => (dispatch, getState) => {
  const state = getState()
  const id = project.id
  const { numberOfDays } = state.projectBuilder.upsell
  const { paymentType, paypalPaymentId, paymentIntentId, paymentMethodId, discountCode } = state.projectBuilder.attributes
  const data = { numberOfDays, paymentType, paypalPaymentId, paymentIntentId, paymentMethodId, discountCode }

  return dispatch(upsellProjectDays(id, data)).then((response) => {
    if (!response.error) {
      const state = getState()

      dispatch(hideModal())
      dispatch(resetProjectUpsellAttributes())
    } else {
      const errors = transformServerErrors(response.payload)

      if (errors) {
        // Stripe authentication via 3D secure
        if (errors['requiresAction']) {
          stripe.handleCardAction(errors['requiresAction'][0]).then(function(result) {
            if (result.error) {
              // dispatch(setCheckoutValidationCreditCardError(result.error.message))
              // TODO
            } else {
              dispatch(changeAttributes({ paymentIntentId: result.paymentIntent.id }))

              const state = getState()
              const data = getCreateOneToOneProjectData(state)

              dispatch(buyDaysUpsell(project))
            }
          })
        } else {
          dispatch(setStepValidationErrors(errors))
        }
      }
    }
  })
}
