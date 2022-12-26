import { combineReducers } from 'redux'

import {
  FINALIST_DESIGNERS_LOAD_REQUEST,
  FINALIST_DESIGNERS_LOAD_SUCCESS,
  FINALIST_DESIGNERS_LOAD_FAILURE
} from '@actions/finalistDesigners'

const ids = (state = [], action) => {
  switch (action.type) {
  case FINALIST_DESIGNERS_LOAD_REQUEST:
  case FINALIST_DESIGNERS_LOAD_FAILURE:
    return []
  case FINALIST_DESIGNERS_LOAD_SUCCESS:
    return action.payload.results.finalistDesigners || []
  default:
    return state
  }
}

const inProgress = (state = true, action) => {
  switch (action.type) {
  case FINALIST_DESIGNERS_LOAD_REQUEST:
    return true
  case FINALIST_DESIGNERS_LOAD_SUCCESS:
  case FINALIST_DESIGNERS_LOAD_FAILURE:
    return false
  default:
    return state
  }
}

export default combineReducers({
  ids,
  inProgress
})
