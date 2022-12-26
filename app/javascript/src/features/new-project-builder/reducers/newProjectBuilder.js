import { combineReducers } from 'redux'
import {
  LOAD_PROJECT_REQUEST, LOAD_PROJECT_SUCCESS, LOAD_PROJECT_FAILURE,
  CREATE_PROJECT_REQUEST, CREATE_PROJECT_SUCCESS, CREATE_PROJECT_FAILURE,
  UPDATE_PROJECT_REQUEST, UPDATE_PROJECT_SUCCESS, UPDATE_PROJECT_FAILURE
} from '../actions/newProjectBuilder'

const project = (state = {}, action) => {
  switch (action.type) {
  case LOAD_PROJECT_SUCCESS:
  case CREATE_PROJECT_SUCCESS:
  case UPDATE_PROJECT_SUCCESS:
    return {
      ...state,
      ...action.payload
    }
  default:
    return state
  }
}

const projectBuilderSteps = (state = [], action) => {
  switch (action.type) {
  case CREATE_PROJECT_SUCCESS:
  case LOAD_PROJECT_SUCCESS:
    return action.payload.product.projectBuilderSteps
  default:
    return state
  }
}

const loadInProgress = (state = false, action) => {
  switch (action.type) {
  case LOAD_PROJECT_REQUEST:
    return true
  case LOAD_PROJECT_SUCCESS:
  case LOAD_PROJECT_FAILURE:
    return false
  default:
    return state
  }
}

const createInProgress = (state = false, action) => {
  switch (action.type) {
  case CREATE_PROJECT_REQUEST:
    return true
  case CREATE_PROJECT_SUCCESS:
  case CREATE_PROJECT_FAILURE:
    return false
  default:
    return state
  }
}

const updateInProgress = (state = false, action) => {
  switch (action.type) {
  case UPDATE_PROJECT_REQUEST:
    return true
  case UPDATE_PROJECT_SUCCESS:
  case UPDATE_PROJECT_FAILURE:
    return false
  default:
    return state
  }
}

export default combineReducers({
  project,
  projectBuilderSteps,
  loadInProgress,
  createInProgress,
  updateInProgress
})
