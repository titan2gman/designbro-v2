import { combineReducers } from 'redux'

const saved = (state = false, action) => {
  switch (action.type) {
  case 'REQUEST_START_NOTIFICATION_SUCCESS':
    return true
  default:
    return state
  }
}

export default combineReducers({ saved })
