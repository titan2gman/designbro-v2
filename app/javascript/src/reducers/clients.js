import includes from 'lodash/includes'

import { combineReducers } from 'redux'

// reducers:

const clientsIds = (state = [], action) => {
  switch (action.type) {
  case 'CLIENTS_LOAD_SUCCESS':
  case 'LOAD_DESIGNER_NDAS_SUCCESS':
  case 'PROJECT_LOAD_SUCCESS':
    return action.payload.results.clients || []
  default:
    return state
  }
}

export default combineReducers({
  ids: clientsIds
})

// helpers:

export const getClientById = (state, id) => {
  if (includes(state.clients.ids, id)) {
    return state.entities.clients[id]
  }
}
