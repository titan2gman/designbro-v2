import { combineReducers } from 'redux'
import {
  LOAD_BRAND_EXAMPLES_REQUEST, LOAD_BRAND_EXAMPLES_SUCCESS, LOAD_BRAND_EXAMPLES_FAILURE,
} from '../actions/brandExamples'

const brandExamples = (state = [], action) => {
  switch (action.type) {
  case LOAD_BRAND_EXAMPLES_REQUEST:
    return []
  case LOAD_BRAND_EXAMPLES_SUCCESS:
    return action.payload
  default:
    return state
  }
}

const loadInProgress = (state = false, action) => {
  switch (action.type) {
  case LOAD_BRAND_EXAMPLES_REQUEST:
    return true
  case LOAD_BRAND_EXAMPLES_SUCCESS:
  case LOAD_BRAND_EXAMPLES_FAILURE:
    return false
  default:
    return state
  }
}

export default combineReducers({
  brandExamples,
  loadInProgress
})
