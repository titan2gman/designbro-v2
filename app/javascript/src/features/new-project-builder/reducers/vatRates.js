import { combineReducers } from 'redux'
import {
  LOAD_VAT_RATES_REQUEST, LOAD_VAT_RATES_SUCCESS, LOAD_VAT_RATES_FAILURE,
} from '../actions/vatRates'

const vatRates = (state = [], action) => {
  switch (action.type) {
  case LOAD_VAT_RATES_REQUEST:
    return []
  case LOAD_VAT_RATES_SUCCESS:
    return action.payload
  default:
    return state
  }
}

const loadInProgress = (state = false, action) => {
  switch (action.type) {
  case LOAD_VAT_RATES_REQUEST:
    return true
  case LOAD_VAT_RATES_SUCCESS:
  case LOAD_VAT_RATES_FAILURE:
    return false
  default:
    return state
  }
}

export default combineReducers({
  vatRates,
  loadInProgress
})
