import { combineReducers } from 'redux'
import {
  LOAD_DISCOUNT_REQUEST, LOAD_DISCOUNT_SUCCESS, LOAD_DISCOUNT_FAILURE,
} from '../actions/discounts'

const discount = (state = null, action) => {
  switch (action.type) {
  case LOAD_DISCOUNT_REQUEST:
    return null
  case LOAD_DISCOUNT_SUCCESS:
    return action.payload
  default:
    return state
  }
}

const loadInProgress = (state = false, action) => {
  switch (action.type) {
  case LOAD_DISCOUNT_REQUEST:
    return true
  case LOAD_DISCOUNT_SUCCESS:
  case LOAD_DISCOUNT_FAILURE:
    return false
  default:
    return state
  }
}

export default combineReducers({
  discount,
  loadInProgress
})
