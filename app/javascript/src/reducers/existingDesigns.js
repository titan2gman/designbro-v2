import { combineReducers } from 'redux'

const ids = (state = [], action) => {
  switch (action.type) {
  case 'PROJECT_LOAD_SUCCESS':
    return action.payload.results.existingDesigns || []
  default:
    return state
  }
}

export default combineReducers({
  ids
})
