import _ from 'lodash'
import { combineReducers } from 'redux'

import {
  CHANGE_PROFILE_ATTRIBUTE,
  CHANGE_PORTFOLIO_WORK_ATTRIBUTE,
  SET_DESIGNER_PROFILE_ERRORS,
  SET_DESIGNER_PORTFOLIO_ERRORS
} from '@actions/designer'

const designerProfileErrors = (state = {}, action) => {
  switch (action.type) {
  case SET_DESIGNER_PROFILE_ERRORS:
    return action.payload
  case CHANGE_PROFILE_ATTRIBUTE:
    if (state[action.name]) {
      return _.omit(state, action.name)
    }
    return state
  default:
    return state
  }
}

const designerPortfolioErrors = (state = {}, action) => {
  switch (action.type) {
  case SET_DESIGNER_PORTFOLIO_ERRORS:
    return action.payload
  case CHANGE_PORTFOLIO_WORK_ATTRIBUTE:
    return {
      ...state,
      [action.payload.productCategoryId]: _.get(state, [action.payload.productCategoryId], []).map((work, index) => {
        return index === action.payload.index ? _.omit(work, action.payload.name) : work
      })
    }
  default:
    return state
  }
}

export default combineReducers({
  designerProfileErrors,
  designerPortfolioErrors
})
