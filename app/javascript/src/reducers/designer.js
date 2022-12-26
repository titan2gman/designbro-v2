import _ from 'lodash'
import { combineReducers } from 'redux'
import moment from 'moment'

import {
  CHANGE_PROFILE_ATTRIBUTE,
  CHANGE_PROFILE_EXPERIENCE,
  DESIGNER_UPDATE_REQUEST,
  DESIGNER_UPDATE_SUCCESS,
  DESIGNER_UPDATE_FAILURE,
  CHANGE_PORTFOLIO_WORK_ATTRIBUTE
} from '@actions/designer'

const defaultProfileAttributes = {
  displayName: '',
  firstName: '',
  lastName: '',
  email: '',
  dateOfBirth: '',
  dateOfBirthDay: '',
  dateOfBirthMonth: '',
  dateOfBirthYear: '',
  experiences: [],
  country: '',
  city: '',
  stateName: '',
  address1: '',
  address2: '',
  zip: '',
  phone: ''
}

const defaultPortfolioAttributes = {}

const profileAttributes = (state = defaultProfileAttributes, action) => {
  switch (action.type) {
  case 'SIGN_IN_EMAIL_SUCCESS':
  case 'VALIDATE_AUTH_SUCCESS':
  case DESIGNER_UPDATE_SUCCESS:
  case 'PORTFOLIO_SETTINGS_UPDATE_SUCCESS': {
    const me = action.payload.data

    return {
      ...state,
      displayName: me.attributes.displayName,
      firstName: me.attributes.firstName,
      lastName: me.attributes.lastName,
      countryCode: _.toUpper(me.attributes.countryCode),
      dateOfBirthMonth: (moment(me.attributes.dateOfBirth).get('month') + 1),
      dateOfBirthDay: (moment(me.attributes.dateOfBirth).get('date')),
      dateOfBirthYear: (moment(me.attributes.dateOfBirth).get('year')),
      dateOfBirth: me.attributes.dateOfBirth,
      gender: me.attributes.gender,
      experienceEnglish: me.attributes.experienceEnglish,
      experiences: me.attributes.experiences,
      email: me.attributes.email,
      city: me.attributes.city,
      stateName: me.attributes.stateName,
      address1: me.attributes.address1,
      address2: me.attributes.address2,
      zip: me.attributes.zip,
      phone: me.attributes.phone,

      description: me.attributes.description,
      languages: me.attributes.languages,
      oneToOneAvailable: me.attributes.oneToOneAvailable,
      avatarPreviewUrl: me.attributes.avatarUrl,
      avatarId: me.attributes.avatarUploadedFileId,
      uploadedHeroImagePreviewUrl: me.attributes.uploadedHeroImageUrl,
      uploadedHeroImageId: me.attributes.uploadedHeroImageUploadedFileId
    }
  }
  case 'EXPERIENCE_UPDATE_SUCCESS': {
    const designerId = action.payload.results.designers[0]
    const designer = action.payload.entities.designers[designerId]

    return {
      ...state,
      experiences: designer.experiences
    }
  }
  case CHANGE_PROFILE_ATTRIBUTE:
    return {
      ...state,
      [action.name]: action.value
    }
  case CHANGE_PROFILE_EXPERIENCE: {
    const currentExperience = state.experiences.find((e) => {
      return e.product_category_id.toString() === action.categoryId
    })

    const newExperiences = currentExperience ? state.experiences.map((e) => {
      return e.product_category_id.toString() === action.categoryId ? {
        ...e,
        experience: action.value
      } : e
    }) : [
      ...state.experiences,
      {
        product_category_id: action.categoryId,
        experience: action.value
      }
    ]

    return {
      ...state,
      experiences: newExperiences
    }
  }
  default:
    return state
  }
}

const portfolioAttributes = (state = defaultPortfolioAttributes, action) => {
  switch (action.type) {
  case 'SIGN_IN_EMAIL_SUCCESS':
  case 'VALIDATE_AUTH_SUCCESS': {
    const me = action.payload.data.attributes
    const newState = {}

    _.each(me.experiences, (e) => {
      if (e.experience !== 'no_experience') {
        newState[e.product_category_id] = _.times(4, (i) => {
          return {
            productCategoryId: e.product_category_id,
          }
        })
      }
    })

    return newState
  }
  case 'PORTFOLIO_LOAD_SUCCESS': {
    const newState = {}

    _.forEach(state, (works, productCategoryId) => {
      const portfolioWorks = _.filter(action.payload.entities.portfolioWorks, { productCategoryId: parseInt(productCategoryId) })
      newState[productCategoryId] = _.isEmpty(portfolioWorks) ? works : portfolioWorks
    })

    return newState
  }
  case CHANGE_PROFILE_EXPERIENCE: {
    const newState = {
      ...state
    }

    if (action.value !== 'no_experience') {
      if (!state[action.categoryId]) {
        newState[action.categoryId] = _.times(4, (i) => {
          return {
            productCategoryId: action.categoryId,
          }
        })
      }
    } else {
      delete newState[action.categoryId]
    }

    return newState
  }
  case CHANGE_PORTFOLIO_WORK_ATTRIBUTE:
    return {
      ...state,
      [action.payload.productCategoryId]: state[action.payload.productCategoryId].map((work, index) => {
        return index === action.payload.index ? {
          ...work,
          [action.payload.name]: action.payload.value
        } : work
      })
    }
  default:
    return state
  }
}

export default combineReducers({
  profileAttributes,
  portfolioAttributes
})
