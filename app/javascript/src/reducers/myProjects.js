import { combineReducers } from 'redux'

const ids = (state = [], action) => {
  switch (action.type) {
  case 'MY_PROJECTS_LOAD_SUCCESS':
    return action.payload.results.projects || []
  default:
    return state
  }
}

const inProgress = (state = true, action) => {
  switch (action.type) {
  case 'MY_PROJECTS_LOAD_REQUEST':
    return true
  case 'MY_PROJECTS_LOAD_SUCCESS':
  case 'MY_PROJECTS_LOAD_FAILURE':
    return false
  default:
    return state
  }
}

export default combineReducers({
  ids,
  inProgress
})
