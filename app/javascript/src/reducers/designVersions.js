import { combineReducers } from 'redux'
import first from 'lodash/first'
import values from 'lodash/values'

const ids = (state = [], action) => {
  switch (action.type) {
  case 'LOAD_DESIGN_VERSIONS_SUCCESS':
    return action.payload.results.designVersions
  default:
    return state
  }
}

const selected = (state = null, action) => {
  switch (action.type) {
  case 'RESTORE_VERSION_SUCCESS':
    return null
  case 'VERSION_UPLOAD_SUCCESS':
    const design = first(values(action.payload.entities.designs))
    return design.imageId.toString()
  case 'SELECT_DESIGN_VERSION':
    return action.value
  default:
    return state
  }
}

const loading = (state = false, action) => {
  switch (action.type) {
  case 'LOAD_DESIGN_VERSIONS_REQUEST':
    return true
  case 'LOAD_DESIGN_VERSIONS_SUCCESS':
  case 'LOAD_DESIGN_VERSIONS_FAILURE':
    return false
  default:
    return state
  }
}

export const getVersions = (state) =>
  state.designVersions.ids.map((id) => state.entities.designVersions[id])

export const getSelectedVersion = (state) =>
  state.designVersions.selected

export default combineReducers({
  ids,
  selected,
  loading
})
