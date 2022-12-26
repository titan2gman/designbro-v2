import pick from 'lodash/pick'
import values from 'lodash/values'
import includes from 'lodash/includes'

import { combineReducers } from 'redux'

// reducers:

const ids = (state = [], action) => {
  switch (action.type) {
  case 'LOAD_NDAS_SUCCESS':
  case 'LOAD_DESIGNER_NDAS_SUCCESS':
    return action.payload.results.ndas || []
  default:
    return state
  }
}

const current = (state = null, action) => {
  switch (action.type) {
  case 'LOAD_NDA_REQUEST':
    return null
  case 'LOAD_NDA_SUCCESS':
    return action.payload.data.result
  default:
    return state
  }
}

const loaded = (state = false, action) => {
  switch (action.type) {
  case 'LOAD_NDA_REQUEST':
    return false
  case 'LOAD_NDA_SUCCESS':
    return true
  default:
    return state
  }
}

export default combineReducers({
  ids, current, loaded
})

// helpers:

export const getCurrentNda = (state) => (
  state.ndas.current && state.entities.nda[state.ndas.current]
)

export const getNdasLoaded = (state) => state.ndas.loading

export const getNdas = ({ entities, ndas }) => (
  values(pick(entities.ndas, ndas.ids))
)

export const getNdaById = (state, id) => {
  if (includes(state.ndas.ids, id)) {
    return state.entities.ndas[id]
  }
}
