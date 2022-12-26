import {
  BRANDS_LOAD_REQUEST,
  BRANDS_LOAD_SUCCESS,
  BRANDS_LOAD_FAILURE,
  BRAND_LOAD_REQUEST,
  BRAND_LOAD_SUCCESS,
  BRAND_LOAD_FAILURE,
  BRANDS_CHANGE_PAGE
} from '@actions/brands'

import { combineReducers } from 'redux'

const ids = (state = [], action) => {
  switch (action.type) {
  case BRANDS_LOAD_SUCCESS:
    return action.payload.results.brands || []
  default:
    return state
  }
}

const inProgress = (state = true, action) => {
  switch (action.type) {
  case BRANDS_LOAD_REQUEST:
  case BRAND_LOAD_REQUEST:
    return true
  case BRANDS_LOAD_SUCCESS:
  case BRANDS_LOAD_FAILURE:
  case BRAND_LOAD_SUCCESS:
  case BRAND_LOAD_FAILURE:
    return false
  default:
    return state
  }
}

const pager = (state = { currentPage: 0, totalPages: 0 }, action) => {
  switch (action.type) {
  case BRANDS_LOAD_SUCCESS:
    return action.payload.meta || state
  case BRANDS_CHANGE_PAGE:
    return { ...state, currentPage: action.page }
  default:
    return state
  }
}

export default combineReducers({
  ids,
  inProgress,
  pager
})

export const getBrandsPager = ({ brands: { pager } }) => ({
  current: pager.currentPage, total: pager.totalPages
})

