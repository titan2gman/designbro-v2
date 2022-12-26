import _ from 'lodash'
import isEmpty from 'lodash/isEmpty'
import map from 'lodash/map'
import last from 'lodash/last'
import take from 'lodash/take'
import union from 'lodash/union'
import first from 'lodash/first'
import values from 'lodash/values'
import without from 'lodash/without'
import includes from 'lodash/includes'
import pick from 'lodash/pick'

import { combineReducers } from 'redux'

import {
  PROJECT_CREATE_REQUEST,
  PROJECT_CREATE_SUCCESS,
  PROJECT_CREATE_FAILURE,
  PROJECT_LOAD_REQUEST,
  PROJECT_LOAD_SUCCESS,
  PROJECT_LOAD_FAILURE,
  CHANGE_PROJECT_PRODUCT_ATTRIBUTE,
} from '@actions/newProject'

import {
  CHANGE_PROJECT_DETAILS_ATTRIBUTE,
  CHANGE_PROJECT_CHECKOUT_ATTRIBUTE,
} from '@actions/clientNewProject'

import {
  BRANDS_LOAD_SUCCESS,
  BRANDS_LOAD_FAILURE
} from '@actions/brands'

const defaultClientProjectDetailsAttributes = {
  ndaValue: '',
  discountCode: '',
  maxSpotsCount: 3,
  ndaTypeExist: 'no',
  ndaType: 'free',
  maxScreensCount: 1
}

const defaultClientProjectCheckoutAttributes = {
  firstName: '',
  lastName: '',
  companyName: '',
  countryCode: '',
  vat: '',
  paymentType: 'credit_card'
}

const stepProductAttributes = (state = {}, action) => {
  switch (action.type) {
  case BRANDS_LOAD_SUCCESS: {
    const brand = _.values(action.payload.entities.brands)[0]

    return {
      ...state,
      brandId: brand && brand.id,
      isNewBrand: !brand
    }
  }
  case BRANDS_LOAD_FAILURE:
    return {
      ...state,
      isNewBrand: true
    }
  case CHANGE_PROJECT_PRODUCT_ATTRIBUTE:
    return {
      ...state,
      [action.name]: action.value
    }
  case PROJECT_CREATE_SUCCESS:
    return {}
  default:
    return state
  }
}

const rebuildEntities = (name, value, state) => {
  let existingDesigns = state.existingDesigns
  let competitors = state.competitors
  let inspirations = state.inspirations
  let projectStockImages = state.projectStockImages
  let colors = state.colors

  if (name === 'logosExist' && value === 'yes' && existingDesigns.length === 0) {
    existingDesigns = [{}]
  }

  if (name === 'competitorsExist' && value === 'yes' && competitors.length === 0) {
    competitors = [{}]
  }

  if (name === 'stockImagesExist' && value === 'yes' && projectStockImages.length === 0) {
    projectStockImages = [{}]
  }

  if (name === 'inspirationsExist' && value === 'yes' && inspirations.length === 0) {
    inspirations = [{}]
  }

  if (name === 'colorsExist' && value === 'yes' && colors.length === 0) {
    colors = [undefined]
  }

  return {
    competitors,
    existingDesigns,
    inspirations,
    projectStockImages,
    colors
  }
}


const stepDetailsAttributes = (state = defaultClientProjectDetailsAttributes, action) => {
  switch (action.type) {
  case PROJECT_LOAD_SUCCESS: {
    const brandId = action.payload.results.brands[0]
    const projectId = action.payload.results.projects[0]
    const brand = action.payload.entities.brands[brandId]
    const project = action.payload.entities.projects[projectId]
    const ndaId = brand.ndas[0]
    const nda = ndaId && action.payload.entities.ndas[ndaId]
    const discountCode = project.discountCode

    return {
      ...state,
      ndaType: nda && nda.ndaType || defaultClientProjectDetailsAttributes.ndaType,
      ndaValue: nda && nda.value,
      ndaTypeExist: nda && nda.ndaType !== 'free' ? 'yes' : 'no',
      ndaIsPaid: nda && nda.paid,
      maxSpotsCount: project.maxSpotsCount,
      maxScreensCount: project.maxScreensCount,
      upgradePackage: project.upgradePackage ? 'yes' : 'no',
      discountCode
    }
  }
  case CHANGE_PROJECT_DETAILS_ATTRIBUTE:
    return {
      ...state,
      [action.name]: action.value
    }
  default:
    return state
  }
}

const stepCheckoutAttributes = (state = defaultClientProjectCheckoutAttributes, action) => {
  switch (action.type) {
  case 'VALIDATE_AUTH_SUCCESS': {
    const me = action.payload.data

    return {
      ...state,
      firstName: me.attributes.firstName,
      lastName: me.attributes.lastName,
      vat: me.attributes.vat,
      countryCode: me.attributes.countryCode,
      paymentType: me.attributes.preferredPaymentMethod || defaultClientProjectCheckoutAttributes.paymentType
    }
  }
  case PROJECT_LOAD_SUCCESS: {
    const brandId = action.payload.results.brands[0]
    const projectId = action.payload.results.projects[0]
    const brand = action.payload.entities.brands[brandId]
    const project = action.payload.entities.projects[projectId]

    const company = action.payload.entities.companies && action.payload.entities.companies[brand.company]

    return {
      ...state,
      companyName: company && company.companyName,
      countryCode: company && company.countryCode,
      vat: company && company.vat
    }
  }
  case CHANGE_PROJECT_CHECKOUT_ATTRIBUTE:
    return {
      ...state,
      [action.name]: action.value
    }
  default:
    return state
  }
}

const isProjectBrandExampleBad = (projectBrandExample) => (
  projectBrandExample.exampleType === 'bad'
)

const isProjectBrandExampleGood = (projectBrandExample) => (
  projectBrandExample.exampleType === 'good'
)

const isProjectBrandExampleSkip = (projectBrandExample) => (
  projectBrandExample.exampleType === 'skip'
)

// reducers

const badExamples = (state = [], action) => {
  const id = action.brandExampleId

  switch (action.type) {
  case 'MARK_EXAMPLE_AS_BAD':
    return union(state, [id])
  case 'MARK_EXAMPLE_AS_CANCELLED':
    return without(state, id)
  case PROJECT_LOAD_SUCCESS:
    const projectBrandExamples = values(action.payload.entities.projectBrandExamples)
    const badProjectBrandExamples = projectBrandExamples.filter(isProjectBrandExampleBad)

    return map(badProjectBrandExamples, 'brandExample')
  case PROJECT_CREATE_SUCCESS:
  case PROJECT_LOAD_FAILURE:
    return []
  default:
    return state
  }
}

const goodExamples = (state = [], action) => {
  const id = action.brandExampleId

  switch (action.type) {
  case 'MARK_EXAMPLE_AS_GOOD':
    return union(state, [id])
  case 'MARK_EXAMPLE_AS_CANCELLED':
    return without(state, id)
  case PROJECT_LOAD_SUCCESS:
    const projectBrandExamples = values(action.payload.entities.projectBrandExamples)
    const goodProjectBrandExamples = projectBrandExamples.filter(isProjectBrandExampleGood)

    return map(goodProjectBrandExamples, 'brandExample')
  case PROJECT_CREATE_SUCCESS:
  case PROJECT_LOAD_FAILURE:
    return []
  default:
    return state
  }
}

const skipExamples = (state = [], action) => {
  const id = action.brandExampleId

  switch (action.type) {
  case 'MARK_EXAMPLE_AS_SKIP':
    return union(state, [id])
  case 'MARK_EXAMPLE_AS_BAD':
  case 'MARK_EXAMPLE_AS_GOOD':
    return without(state, id)
  case PROJECT_LOAD_SUCCESS:
    const projectBrandExamples = values(action.payload.entities.projectBrandExamples)
    const skipProjectBrandExamples = projectBrandExamples.filter(isProjectBrandExampleSkip)

    return map(skipProjectBrandExamples, 'brandExample')
  case PROJECT_CREATE_SUCCESS:
  case PROJECT_LOAD_FAILURE:
    return []
  default:
    return state
  }
}

const cancelledExamples = (state = [], action) => {
  const id = action.brandExampleId

  switch (action.type) {
  case 'MARK_EXAMPLE_AS_CANCELLED':
    return union(state, [id])
  case 'MARK_EXAMPLE_AS_BAD':
  case 'MARK_EXAMPLE_AS_GOOD':
    return without(state, id)
  case PROJECT_CREATE_SUCCESS:
    return []
  default:
    return state
  }
}

const skipAndCancelledExamplesIndex = (state = 0, action) => {
  switch (action.type) {
  case 'INCREMENT_SKIP_AND_CANCELLED_EXAMPLES_INDEX':
    return state + 1
  default:
    return state
  }
}

const examplesStep = combineReducers({
  skipAndCancelledExamplesIndex,
  cancelledExamples,
  skipExamples,
  goodExamples,
  badExamples
})

const inProgress = (state = true, action) => {
  switch (action.type) {
  case PROJECT_LOAD_REQUEST:
  case PROJECT_CREATE_REQUEST:
    return true
  case PROJECT_LOAD_SUCCESS:
  case PROJECT_LOAD_FAILURE:
  case PROJECT_CREATE_SUCCESS:
  case PROJECT_CREATE_FAILURE:
    return false
  default:
    return state
  }
}

export default combineReducers({
  stepProductAttributes,
  stepDetailsAttributes,
  stepCheckoutAttributes,

  examplesStep,
  inProgress
})

// selectors
// TODO: move to selectors

export const generateGetExamplesFunction = (group) => (state) =>
  state.newProject.examplesStep[`${group.toLowerCase()}Examples`]
    .map((id) => state.entities.brandExamples[id])

export const getBadExamples = generateGetExamplesFunction('BAD')
export const getGoodExamples = generateGetExamplesFunction('GOOD')
export const getSkipExamples = generateGetExamplesFunction('SKIP')
export const getCancelledExamples = generateGetExamplesFunction('CANCELLED')

export const getSkipAndCancelledExamples = (state) => (
  [
    ...getSkipExamples(state),
    ...getCancelledExamples(state)
  ]
)

export const getSkipAndCancelledExamplesIndex = (state) => (
  state.newProject.examplesStep.skipAndCancelledExamplesIndex
)
