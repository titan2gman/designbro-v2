import {
  LOAD_PRODUCTS_REQUEST,
  LOAD_PRODUCTS_SUCCESS,
  LOAD_PRODUCTS_FAILURE
} from '@actions/products'

import { combineReducers } from 'redux'

const inProgress = (state = true, action) => {
  switch (action.type) {
  case LOAD_PRODUCTS_REQUEST:
    return true
  case LOAD_PRODUCTS_SUCCESS:
  case LOAD_PRODUCTS_FAILURE:
    return false
  default:
    return state
  }
}

export default combineReducers({
  inProgress
})
