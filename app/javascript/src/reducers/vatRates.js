import {
  LOAD_VAT_RATES_REQUEST,
  LOAD_VAT_RATES_SUCCESS,
  LOAD_VAT_RATES_FAILURE
} from '@actions/vatRates'

import { combineReducers } from 'redux'

const inProgress = (state = true, action) => {
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
  inProgress
})
