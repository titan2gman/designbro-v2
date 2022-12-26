import { combineReducers } from 'redux'
import {
  LOAD_PRODUCTS_REQUEST, LOAD_PRODUCTS_SUCCESS, LOAD_PRODUCTS_FAILURE,
} from '../actions/products'

const products = (state = [], action) => {
  switch (action.type) {
  case LOAD_PRODUCTS_REQUEST:
    return []
  case LOAD_PRODUCTS_SUCCESS:
    return action.payload
  default:
    return state
  }
}

const loadInProgress = (state = false, action) => {
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
  products,
  loadInProgress
})
