import {
  LOAD_PRODUCT_CATEGORIES_REQUEST,
  LOAD_PRODUCT_CATEGORIES_SUCCESS,
  LOAD_PRODUCT_CATEGORIES_FAILURE
} from '@actions/productCategories'

import { combineReducers } from 'redux'

const inProgress = (state = true, action) => {
  switch (action.type) {
  case LOAD_PRODUCT_CATEGORIES_REQUEST:
    return true
  case LOAD_PRODUCT_CATEGORIES_SUCCESS:
  case LOAD_PRODUCT_CATEGORIES_FAILURE:
    return false
  default:
    return state
  }
}

export default combineReducers({
  inProgress
})
