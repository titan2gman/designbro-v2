import find from 'lodash/find'
import pick from 'lodash/pick'
import values from 'lodash/values'

import {
  LOAD_NDA_PRICES_REQUEST,
  LOAD_NDA_PRICES_SUCCESS,
  LOAD_NDA_PRICES_FAILURE
} from '@actions/ndaPrices'

import { combineReducers } from 'redux'

const inProgress = (state = true, action) => {
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

const ids = (state = [], action) => {
  switch (action.type) {
  case LOAD_NDA_PRICES_SUCCESS:
    return action.payload.results.ndaPrices || []
  default:
    return state
  }
}

export default combineReducers({ inProgress, ids })

export const getNdaPrices = (state) => (
  values(pick(state.entities.ndaPrices, state.ndaPrices.ids))
)

export const getNdaPriceByNdaType = (state, ndaType) => (
  find(getNdaPrices(state), { ndaType })
)
