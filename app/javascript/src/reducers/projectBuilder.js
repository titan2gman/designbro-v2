import _ from 'lodash'
import { combineReducers } from 'redux'

import {
  PROJECT_CREATE_REQUEST,
  PROJECT_CREATE_SUCCESS,
  PROJECT_CREATE_FAILURE,
} from '@actions/newProject'

import {
  PROJECT_LOAD_REQUEST,
  PROJECT_LOAD_SUCCESS,
  PROJECT_LOAD_FAILURE,
  PROJECT_UPDATE_SUCCESS,
  CHANGE_PROJECT_BUILDER_ATTRIBUTES,
  SET_PROJECT_COLOR_BY_INDEX,
  REMOVE_PROJECT_COLOR_BY_INDEX,

  SET_PROJECT_BUILDER_VALIDATION_ERRORS,

  CHANGE_PROJECT_UPSELL_ATTRIBUTES,
  RESET_PROJECT_UPSELL_ATTRIBUTES
} from '@actions/projectBuilder'

import {
  EXISTING_DESIGN_UPLOAD_SUCCESS,
  COMPETITOR_UPLOAD_SUCCESS,
  INSPIRATION_UPLOAD_SUCCESS,
  ADDITIONAL_DOCUMENT_UPLOAD_SUCCESS,
  STOCK_IMAGE_UPLOAD_SUCCESS,
  REMOVE_BRAND_RELATED_ENTITY_FROM_THE_LIST,
  CHANGE_BRAND_RELATED_ENTITY_IN_THE_LIST
} from '@actions/brandRelatedEntities'

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

const getCurrentProject = (payload) => {
  const projectId = payload.results.projects[0]
  return payload.entities.projects[projectId]
}

const getAllStepsQuestions = (payload) => {
  const currentProject = getCurrentProject(payload)
  const productId = currentProject.productId

  return _.filter(payload.entities.projectBuilderQuestions, { productId })
}

const getAttributeNames = (payload) => {
  const questions = getAllStepsQuestions(payload)

  return _.map(questions, (question) => _.camelCase(question.attributeName)).filter(Boolean)
}

const getBrandId = (payload) => {
  return payload.results.brands[0]
}

const listOfObjectsWithEmpty = (list, maxCount) => {
  return list.length < maxCount && !_.isEmpty(list[list.length - 1]) ? [...list, {}] : list
}

const buildCompetitors = (payload) => {
  if (payload.results.competitors) {
    const competitors = payload.results.competitors.map((id) => {
      return {
        uploadedFileId: payload.entities.competitors[id].uploadedFileId,
        comment: payload.entities.competitors[id].comment,
        previewUrl: payload.entities.competitors[id].url,
        name: payload.entities.competitors[id].name,
        website: payload.entities.competitors[id].website,
        rate: payload.entities.competitors[id].rate
      }
    })

    return listOfObjectsWithEmpty(competitors, 4)
  } else {
    return []
  }
}


const buildExistingDesigns = (payload, productKey) => {
  if (payload.results.existingDesigns) {
    const existingDesigns = payload.results.existingDesigns.map((id) => {
      return {
        uploadedFileId: payload.entities.existingDesigns[id].uploadedFileId,
        comment: payload.entities.existingDesigns[id].comment,
        previewUrl:  payload.entities.existingDesigns[id].url
      }
    })

    return listOfObjectsWithEmpty(existingDesigns, 4)
  } else if (['website', 'website-banner', 'flyer', 'poster', 'menu', 'billboard', 'book-cover', 'album-cover', 'magazine-cover', 't-shirt', 'business-card', 'instagram-post', 'facebook', 'twitter', 'linkedin', 'youtube'].includes(productKey)) {
    return [{}]
  } else {
    return []
  }
}

const buildInspirations = (payload) => {
  if (payload.results.inspirations) {
    const inspirations = payload.results.inspirations.map((id) => {
      return {
        uploadedFileId: payload.entities.inspirations[id].uploadedFileId,
        comment: payload.entities.inspirations[id].comment,
        previewUrl:  payload.entities.inspirations[id].url
      }
    })

    return listOfObjectsWithEmpty(inspirations, 4)
  } else {
    return []
  }
}

const buildStockImages = (payload) => {
  if (payload.results.projectStockImages) {
    const projectStockImages = payload.results.projectStockImages.map((id) => {
      return {
        uploadedFileId: payload.entities.projectStockImages[id].uploadedFileId,
        comment: payload.entities.projectStockImages[id].comment,
        previewUrl:  payload.entities.projectStockImages[id].url
      }
    })

    return listOfObjectsWithEmpty(projectStockImages, 4)
  } else {
    return []
  }
}

const buildAdditionalDocuments = (payload) => {
  if (payload.results.projectAdditionalDocuments) {
    const projectAdditionalDocuments = payload.results.projectAdditionalDocuments.map((id) => {
      return {
        uploadedFileId: payload.entities.projectAdditionalDocuments[id].uploadedFileId,
        comment: payload.entities.projectAdditionalDocuments[id].comment,
        previewUrl:  payload.entities.projectAdditionalDocuments[id].url
      }
    })

    return listOfObjectsWithEmpty(projectAdditionalDocuments, 4)
  } else {
    return [{}]
  }
}

const buildColors = (payload) => {
  if (payload.results.projectColors) {
    const projectColors = payload.results.projectColors.map((id) => {
      return payload.entities.projectColors[id].hex
    })

    return [...projectColors, undefined]
  } else {
    return [undefined]
  }
}

const rebuildEntities = (payload, state) => {
  let existingDesigns = state.existingDesigns
  let competitors = state.competitors
  let inspirations = state.inspirations
  let projectStockImages = state.projectStockImages
  const colors = state.colors

  if (payload.existingDesignsExist === 'yes' && existingDesigns.length === 0) {
    existingDesigns = [{}]
  }

  if (payload.competitorsExist === 'yes' && competitors.length === 0) {
    competitors = [{}]
  }

  if (payload.stockImagesExist === 'yes' && projectStockImages.length === 0) {
    projectStockImages = [{}]
  }

  if (payload.inspirationsExist === 'yes' && inspirations.length === 0) {
    inspirations = [{}]
  }

  return {
    competitors,
    existingDesigns,
    inspirations,
    projectStockImages
  }
}

const defaultAttributes = {
  targetCountryCodes: [],
  competitorsExist: 'no',
  existingDesignsExist: 'no',
  inspirationsExist: 'no',
  colorsExist: 'no',
  stockImagesExist: 'no',
  hasExistingDesigns: false,
  brandExists: 'no',

  // details step
  maxSpotsCount: 3,
  maxScreensCount: 1,
  ndaType: 'free',

  // checkout step
  paymentType: 'credit_card'
}

const attributes = (state = defaultAttributes, action) => {
  switch (action.type) {
  case 'VALIDATE_AUTH_SUCCESS': {
    const me = action.payload.data

    return {
      ...state,
      firstName: me.attributes.firstName,
      lastName: me.attributes.lastName,
      vat: me.attributes.vat,
      countryCode: _.toUpper(me.attributes.countryCode),
      paymentType: me.attributes.preferredPaymentMethod || defaultAttributes.paymentType
    }
  }
  case PROJECT_LOAD_SUCCESS:
  case PROJECT_CREATE_SUCCESS: {
    if (!action.payload.results) {
      return state
    }

    const project = getCurrentProject(action.payload)
    const attributeNames = getAttributeNames(action.payload)
    const attributes = _.pick(project, attributeNames)

    const brandId = getBrandId(action.payload)
    const brand = action.payload.entities.brands[brandId]

    const ndaId = brand.ndas[0]
    const nda = ndaId && action.payload.entities.ndas[ndaId]

    const colors = buildColors(action.payload)

    const competitors = buildCompetitors(action.payload)

    const existingDesigns = buildExistingDesigns(action.payload, project.productKey)

    const inspirations = buildInspirations(action.payload)

    const projectAdditionalDocuments = buildAdditionalDocuments(action.payload)

    const projectStockImages = buildStockImages(action.payload)

    return {
      ...state,
      ...attributes,

      brandId,
      brandExists: project.productKey === 'zoom-background' && !project.brandName ? 'no' : 'yes',
      brandName: project.brandName,

      isNewBrand: false,

      colors,
      colorsExist: colors.length > 1 || project.colorsComment ? 'yes' : 'no',
      colorsComment: project.colorsComment,

      competitorsExist: competitors.length ? 'yes' : 'no',
      competitors,

      existingDesignsExist: existingDesigns.length ? 'yes' : 'no',
      existingDesigns,
      hasExistingDesigns: project.hasExistingDesigns,
      sourceFilesShared: project.sourceFilesShared ? 'yes' : 'no',

      inspirationsExist: inspirations.length ? 'yes' : 'no',
      inspirations,

      stockImagesExist: project.stockImagesExist,
      projectStockImages,

      projectAdditionalDocuments,

      // details step
      ndaType: nda && nda.ndaType || defaultAttributes.ndaType,
      ndaValue: nda && nda.value,
      ndaIsPaid: nda && nda.paid,
      discountCode: project.discountCode,
      maxSpotsCount: project.maxSpotsCount,
      maxScreensCount: project.maxScreensCount,
      upgradePackage: project.upgradePackage,

      // checkout step
      companyName: project.companyCompanyName,
      countryCode: _.toUpper(project.companyCountryCode),
      vat: project.companyVat
    }
  }
  case CHANGE_PROJECT_BUILDER_ATTRIBUTES: {
    return {
      ...state,
      ...action.payload,
      ...rebuildEntities(action.payload, state)
    }
  }
  case SET_PROJECT_COLOR_BY_INDEX: {
    const { index, color } = action

    let colors = [
      ...state.colors.slice(0, index),
      color,
      ...state.colors.slice(index + 1, state.colors.length)
    ]

    if (!_.includes(colors, undefined)) {
      colors = [...colors, undefined]
    }

    return {
      ...state,
      colors
    }
  }
  case REMOVE_PROJECT_COLOR_BY_INDEX: {
    const { index } = action

    const colors = [
      ...state.colors.slice(0, index),
      ...state.colors.slice(index + 1, state.colors.length)
    ]

    return {
      ...state,
      colors
    }
  }
  case COMPETITOR_UPLOAD_SUCCESS:
    return {
      ...state,
      competitors: listOfObjectsWithEmpty(state.competitors, 4)
    }
  case EXISTING_DESIGN_UPLOAD_SUCCESS:
    return {
      ...state,
      existingDesigns: listOfObjectsWithEmpty(state.existingDesigns, 4)
    }
  case INSPIRATION_UPLOAD_SUCCESS:
    return {
      ...state,
      inspirations: listOfObjectsWithEmpty(state.inspirations, 4)
    }
  case ADDITIONAL_DOCUMENT_UPLOAD_SUCCESS:
    return {
      ...state,
      projectAdditionalDocuments: listOfObjectsWithEmpty(state.projectAdditionalDocuments, 4)
    }
  case STOCK_IMAGE_UPLOAD_SUCCESS:
    return {
      ...state,
      projectStockImages: listOfObjectsWithEmpty(state.projectStockImages, 4)
    }
  case REMOVE_BRAND_RELATED_ENTITY_FROM_THE_LIST: {
    const entities = state[action.payload.entityName].filter((logo, index) => {
      return index !== action.payload.index
    })

    return {
      ...state,
      [action.payload.entityName]: listOfObjectsWithEmpty(entities, 4)
    }
  }
  case CHANGE_BRAND_RELATED_ENTITY_IN_THE_LIST: {
    const entities = state[action.payload.entityName].map((entity, index) => {
      return index === action.payload.index ? {
        ...entity,
        [action.payload.name]: action.payload.value
      } : entity
    })

    return {
      ...state,
      [action.payload.entityName]: entities
    }
  }
  default:
    return state
  }
}

export const validation = (state = {}, action) => {
  switch (action.type) {
  case SET_PROJECT_BUILDER_VALIDATION_ERRORS:
    return action.payload
  case CHANGE_PROJECT_BUILDER_ATTRIBUTES:
    return _.omit(state, _.keys(action.payload))
  case CHANGE_BRAND_RELATED_ENTITY_IN_THE_LIST:
    return _.omit(state, action.payload.entityName)
  case 'MARK_EXAMPLE_AS_GOOD':
    return _.omit(state, 'goodExamples')
  default:
    return state
  }
}

const defaultUpsell = {
  numberOfSpots: 1,
  numberOfDays: 1
}

export const upsell = (state = defaultUpsell, action) => {
  switch (action.type) {
  case CHANGE_PROJECT_UPSELL_ATTRIBUTES:
    return {
      ...state,
      ...action.payload,
    }
  case RESET_PROJECT_UPSELL_ATTRIBUTES:
    return defaultUpsell
  default:
    return state
  }
}

export default combineReducers({
  inProgress,
  attributes,
  upsell,
  validation,
})
