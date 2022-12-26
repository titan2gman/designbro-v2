import { combineReducers } from 'redux'
import {
  LOAD_BRANDS_REQUEST, LOAD_BRANDS_SUCCESS, LOAD_BRANDS_FAILURE,
} from '../actions/brands'

const brands = (state = [], action) => {
  switch (action.type) {
  case LOAD_BRANDS_REQUEST:
    return []
  case LOAD_BRANDS_SUCCESS:
    return action.payload
  default:
    return state
  }
}

const loadInProgress = (state = false, action) => {
  switch (action.type) {
  case LOAD_BRANDS_REQUEST:
    return true
  case LOAD_BRANDS_SUCCESS:
  case LOAD_BRANDS_FAILURE:
    return false
  default:
    return state
  }
}

export default combineReducers({
  brands,
  loadInProgress
})
