import { combineReducers } from 'redux'
import {
  LOAD_NDA_PRICES_REQUEST, LOAD_NDA_PRICES_SUCCESS, LOAD_NDA_PRICES_FAILURE,
} from '../actions/ndaPrices'

const ndaPrices = (state = [], action) => {
  switch (action.type) {
  case LOAD_NDA_PRICES_REQUEST:
    return []
  case LOAD_NDA_PRICES_SUCCESS:
    return action.payload
  default:
    return state
  }
}

const loadInProgress = (state = false, action) => {
  switch (action.type) {
  case LOAD_NDA_PRICES_REQUEST:
    return true
  case LOAD_NDA_PRICES_SUCCESS:
  case LOAD_NDA_PRICES_FAILURE:
    return false
  default:
    return state
  }
}

export default combineReducers({
  ndaPrices,
  loadInProgress
})
