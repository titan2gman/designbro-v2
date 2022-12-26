import without from 'lodash/without'

import { combineReducers } from 'redux'

const ids = (state = [], action) => {
  switch (action.type) {
  case 'DESTROY_SOURCE_FILE':
    return without(state, action.id)
  case 'SOURCE_FILE_UPLOAD_SUCCESS':
    return [...state, ...action.payload.results.projectSourceFiles]
  case 'SOURCE_FILES_LOAD_SUCCESS':
    return action.payload.results.projectSourceFiles || []
  default:
    return state
  }
}

const loading = (state = false, action) => {
  switch (action.type) {
  case 'SOURCE_FILES_LOAD_REQUEST':
    return true
  case 'SOURCE_FILES_LOAD_SUCCESS':
  case 'SOURCE_FILES_LOAD_FAILURE':
    return false
  default:
    return state
  }
}


const inProgress = (state = true, action) => {
  switch (action.type) {
  case 'SOURCE_FILES_LOAD_REQUEST':
    return true
  case 'SOURCE_FILES_LOAD_SUCCESS':
  case 'SOURCE_FILES_LOAD_FAILURE':
    return false
  default:
    return state
  }
}

const loaded = (state = false, action) => {
  switch (action.type) {
  case 'SOURCE_FILES_LOAD_REQUEST':
    return false
  case 'SOURCE_FILES_LOAD_SUCCESS':
    return true
  default:
    return state
  }
}

export const getSourceFiles = (state) => (
  state.sourceFiles.ids.map((id) =>
    state.entities.projectSourceFiles[id]
  )
)

export default combineReducers({
  ids,
  loading,
  loaded,
  inProgress
})

export const getSourceFilesLoading = (state) => (
  state.sourceFiles.loading
)

export const getSourceFilesLoaded = (state) => (
  state.sourceFiles.loaded
)
