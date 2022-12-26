import { combineReducers } from 'redux'
import {
  LOAD_BRAND_EXAMPLES_REQUEST,
  LOAD_BRAND_EXAMPLES_SUCCESS,
  LOAD_BRAND_EXAMPLES_FAILURE
} from '@actions/brandExamples'

// reducers

const ids = (state = [], action) => {
  switch (action.type) {
  case LOAD_BRAND_EXAMPLES_SUCCESS:
    return action.payload.results.brandExamples || []
  default:
    return state
  }
}

const loaded = (state = false, action) => {
  switch (action.type) {
  case LOAD_BRAND_EXAMPLES_REQUEST:
    return false
  case LOAD_BRAND_EXAMPLES_SUCCESS:
    return true
  default:
    return state
  }
}

const inProgress = (state = false, action) => {
  switch (action.type) {
  case LOAD_BRAND_EXAMPLES_REQUEST:
    return true
  case LOAD_BRAND_EXAMPLES_SUCCESS:
    return false
  default:
    return state
  }
}

export default combineReducers({
  ids,
  loaded,
  inProgress
})
