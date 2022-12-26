import _ from 'lodash'
import api from '@utils/api'

import { showDesignerShareConfirmModal } from './modal'
import { getMe } from '@reducers/me'
import { validateProfile, isProfileValid, isProfileSettingsValid, validateSettingsProfile } from '../validators/designerProfile'
import { validateDesignerPortfolio, isDesignerPortfolioValid } from '../validators/designerPortfolio'

import { transformServerErrors } from '../validators/serverErrorsTransformer'
import { getFileData } from '@utils/fileUtilities'

export const CHANGE_PROFILE_ATTRIBUTE = 'CHANGE_PROFILE_ATTRIBUTE'
export const CHANGE_PROFILE_EXPERIENCE = 'CHANGE_PROFILE_EXPERIENCE'
export const SET_DESIGNER_PROFILE_ERRORS = 'SET_DESIGNER_PROFILE_ERRORS'
export const SET_DESIGNER_PORTFOLIO_ERRORS = 'SET_DESIGNER_PORTFOLIO_ERRORS'

const setDesignerProfileErrors = (payload) => ({
  type: SET_DESIGNER_PROFILE_ERRORS,
  payload
})

const setDesignerPortfolioErrors = (payload) => ({
  type: SET_DESIGNER_PORTFOLIO_ERRORS,
  payload
})

export const changeProfileAttribute = (name, value) => ({
  type: CHANGE_PROFILE_ATTRIBUTE,
  name,
  value
})

export const changeProfileExperience = (categoryId, value) => ({
  type: CHANGE_PROFILE_EXPERIENCE,
  categoryId,
  value
})

export const DESIGNER_UPDATE_REQUEST = 'DESIGNER_UPDATE_REQUEST'
export const DESIGNER_UPDATE_SUCCESS = 'DESIGNER_UPDATE_SUCCESS'
export const DESIGNER_UPDATE_FAILURE = 'DESIGNER_UPDATE_FAILURE'

export const updateProfileAttributes = (id, designer) => api.patch({
  endpoint: `/api/v1/designers/${id}`,
  body: { designer },

  types: [
    DESIGNER_UPDATE_REQUEST,
    DESIGNER_UPDATE_SUCCESS,
    DESIGNER_UPDATE_FAILURE
  ]
})

export const saveProfileAttributes = (redirectCallback) => (dispatch, getState) => {
  const state = getState()
  const profileAttributes = state.designer.profileAttributes
  const id = state.me.me.id

  const validation = validateProfile(state)

  if (isProfileValid(validation)) {
    dispatch(updateProfileAttributes(id, profileAttributes)).then((response) => {
      if (!response.error) {
        redirectCallback()
      } else {
        const errors = transformServerErrors(response.payload)

        if (errors) {
          dispatch(setDesignerProfileErrors(errors))
        }
      }
    })
  } else {
    dispatch(setDesignerProfileErrors(validation))
  }
}

export const saveProfileSettingsAttributes = (callback) => (dispatch, getState) => {
  const state = getState()
  const profileAttributes = state.designer.profileAttributes
  const id = state.me.me.id

  const validation = validateSettingsProfile(state)

  if (isProfileSettingsValid(validation)) {
    dispatch(updateProfileAttributes(id, profileAttributes)).then((response) => {
      if (!response.error) {
        callback()
      } else {
        const errors = transformServerErrors(response.payload)

        if (errors) {
          dispatch(setDesignerProfileErrors(errors))
        }
      }
    })
  } else {
    dispatch(setDesignerProfileErrors(validation))
  }
}

export const CHANGE_PORTFOLIO_WORK_ATTRIBUTE = 'CHANGE_PORTFOLIO_WORK_ATTRIBUTE'

export const PORTFOLIO_UPLOAD_REQUEST = 'PORTFOLIO_UPLOAD_REQUEST'
export const PORTFOLIO_UPLOAD_SUCCESS = 'PORTFOLIO_UPLOAD_SUCCESS'
export const PORTFOLIO_UPLOAD_FAILURE = 'PORTFOLIO_UPLOAD_FAILURE'

export const changePortfolioWorkAttribute = (productCategoryId, index, name, value) => ({
  type: CHANGE_PORTFOLIO_WORK_ATTRIBUTE,
  payload: {
    productCategoryId,
    index,
    name,
    value
  }
})

export const upload = (file, type) =>
  api.post({
    endpoint: '/api/v1/uploaded_files',
    types: [
      PORTFOLIO_UPLOAD_REQUEST,
      PORTFOLIO_UPLOAD_SUCCESS,
      PORTFOLIO_UPLOAD_FAILURE
    ],
    body: getFileData({ file, type })
  })

export const uploadPortfolioFile = (productCategoryId, portfolioWorkIndex) => (dispatch) => (file) => {
  dispatch(upload(file, 'designer_portfolio_work')).then((response) => {
    if (response.error) {
      window.alert(response.payload.response.errors.file.join('\n'))
    } else {
      dispatch(changePortfolioWorkAttribute(productCategoryId, portfolioWorkIndex, 'uploadedFileId', response.payload.data.id))
      dispatch(changePortfolioWorkAttribute(productCategoryId, portfolioWorkIndex, 'new', true))
    }
  })

  dispatch(changePortfolioWorkAttribute(productCategoryId, portfolioWorkIndex, 'previewUrl', file.preview))
}

export const submitPortfolio = () => (dispatch, getState) => {
  const state = getState()

  const validation = validateDesignerPortfolio(state)

  if (isDesignerPortfolioValid(validation)) {
    dispatch(showDesignerShareConfirmModal({
      submit: (redirectCallback) => { dispatch(createPortfolio(redirectCallback)) }
    }))
  } else {
    dispatch(setDesignerPortfolioErrors(validation))
  }
}

const saveExperienceSettings = (id, designer) =>
  api.patch({
    endpoint: `/api/v1/designers/${id}/experience`,
    body: { designer },
    normalize: true,

    types: [
      'EXPERIENCE_UPDATE_START',
      'EXPERIENCE_UPDATE_SUCCESS',
      'EXPERIENCE_UPDATE_FAILURE'
    ]
  })

export const submitExperienceSettings = () => (dispatch, getState) => {
  const state = getState()

  const validation = validateDesignerPortfolio(state)

  if (isDesignerPortfolioValid(validation)) {
    dispatch(showDesignerShareConfirmModal({
      submit: (redirectCallback) => { dispatch(updateExperienceSettings(redirectCallback)) }
    }))
  } else {
    dispatch(setDesignerPortfolioErrors(validation))
  }
}

export const updateExperienceSettings = (redirectCallback) => (dispatch, getState) => {
  const state = getState()

  const id = getMe(state).id
  const data = {
    experiences: state.designer.profileAttributes.experiences,
    portfolioWorks: _.flatten(_.values(state.designer.portfolioAttributes))
  }

  dispatch(saveExperienceSettings(id, data))
    .then((response) => {
      if (!response.error) {
        redirectCallback()
      }
    })
}

export const PORTFOLIO_CREATE_REQUEST = 'PORTFOLIO_CREATE_REQUEST'
export const PORTFOLIO_CREATE_SUCCESS = 'PORTFOLIO_CREATE_SUCCESS'
export const PORTFOLIO_CREATE_FAILURE = 'PORTFOLIO_CREATE_FAILURE'

const create = (portfolio) =>
  api.post({
    endpoint: '/api/v1/portfolios',
    types: [
      PORTFOLIO_CREATE_REQUEST,
      PORTFOLIO_CREATE_SUCCESS,
      PORTFOLIO_CREATE_FAILURE
    ],
    body: { portfolio }
  })

export const createPortfolio = (redirectCallback) => (dispatch, getState) => {
  const state = getState()

  const portfolioWorks = _.flatten(_.values(state.designer.portfolioAttributes))

  const portfolio = {
    portfolioWorks
  }

  dispatch(create(portfolio)).then((response) => {
    if (!response.error) {
      redirectCallback()
    }
  })
}

export const incrementActiveSpotsCount = () => ({
  type: 'INCREMENT_ACTIVE_SPOTS_COUNT'
})

const updatePortfolioSetingsAttributes = (id, designer) =>
  api.patch({
    endpoint: `/api/v1/designers/${id}/portfolio_settings`,
    body: { designer },

    types: [
      'PORTFOLIO_SETTINGS_UPDATE_START',
      'PORTFOLIO_SETTINGS_UPDATE_SUCCESS',
      'PORTFOLIO_SETTINGS_UPDATE_FAILURE'
    ]
  })

export const savePortfolioSettings = () => (dispatch, getState) => {
  const state = getState()
  const profileAttributes = state.designer.profileAttributes
  const id = state.me.me.id

  const portfolioSettingsAttributes = _.pick(profileAttributes, ['description', 'languages', 'oneToOneAvailable', 'avatarId', 'uploadedHeroImageId'])

  dispatch(updatePortfolioSetingsAttributes(id, portfolioSettingsAttributes))
}

export const uploadProfileImage = (name) => (dispatch, getState) => (file) => {
  dispatch(upload(file, name)).then((response) => {
    if (response.error) {
      window.alert(response.payload.response.errors.file.join('\n'))
    } else {
      dispatch(changeProfileAttribute(`${name}Id`, response.payload.data.id))
      dispatch(savePortfolioSettings())
    }
  })

  dispatch(changeProfileAttribute(`${name}PreviewUrl`, file.preview))
}

export const destroyProfileImage = (name, uploadedFileId) => (dispatch, getState) => () => {
  dispatch(changeProfileAttribute(`${name}PreviewUrl`, null))
  dispatch(changeProfileAttribute(`${name}Id`, null))
  dispatch(savePortfolioSettings())
}
