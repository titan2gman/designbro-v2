import pick from 'lodash/pick'
import values from 'lodash/values'
import filter from 'lodash/filter'
import isEmpty from 'lodash/isEmpty'
import includes from 'lodash/includes'

import { combineReducers } from 'redux'

import { getMe } from '@reducers/me'

// reducers

const ids = (state = [], action) => {
  switch (action.type) {
  case 'PROJECT_LOAD_SUCCESS':
  case 'MY_DESIGNS_LOAD_SUCCESS':
    return action.payload.results.designs || []
  case 'DESIGN_FILE_UPLOAD_SUCCESS':
    return [ ...state, action.payload.results.designs[0] ]
  default:
    return state
  }
}

const current = (state = null, action) => {
  switch (action.type) {
  case 'LOAD_DESIGN_SUCCESS':
  case 'RESTORE_VERSION_SUCCESS':
    return action.payload.results.designs[0]
  default:
    return state
  }
}

const viewMode = (state = 'normal', action) => {
  switch (action.type) {
  case 'CHANGE_VIEW_MODE':
    return action.value
  default:
    return state
  }
}

const loaded = (state = false, action) => {
  switch (action.type) {
  case 'MY_DESIGNS_LOAD_SUCCESS':
  case 'LOAD_DESIGN_SUCCESS':
    return true
  case 'MY_DESIGNS_LOAD_REQUEST':
  case 'LOAD_DESIGN_REQUEST':
    return false
  default:
    return state
  }
}

const designUploaded = (state = true, action) => {
  switch (action.type) {
  case 'VERSION_UPLOAD_REQUEST':
    return false
  case 'VERSION_UPLOAD_SUCCESS':
    return true
  default:
    return state
  }
}

const showChat = (state = true, action) => {
  switch (action.type) {
  case 'CLOSE_DIRECT_CONVERSATION_CHAT':
    return false
  default:
    return state
  }
}


const inProgress = (state = true, action) => {
  switch (action.type) {
  case 'MY_DESIGNS_LOAD_REQUEST':
  case 'LOAD_DESIGN_REQUEST':
    return true
  case 'MY_DESIGNS_LOAD_SUCCESS':
  case 'LOAD_DESIGN_SUCCESS':
  case 'MY_DESIGNS_LOAD_FAILURE':
  case 'LOAD_DESIGN_FAILURE':
    return false
  default:
    return state
  }
}

export default combineReducers({
  ids,
  loaded,
  inProgress,
  current,
  viewMode,
  showChat,

  designUploaded
})

// helpers

export const getViewMode = (state) => state.designs.viewMode

export const getDesigns = ({ entities, designs }) => (
  values(pick(entities.designs, designs.ids))
)

export const getDesign = ({ entities, designs }) => {
  return entities.designs[designs.current]
}

export const getDesignById = (state, id) => {
  return state.entities.designs[id]
}

export const getDesignLoaded = (state) => state.designs.loaded

export const getShowChat = (state) =>
  state.designs.showChat

export const getDesignUploaded = (state) => state.designs.designUploaded

export const getMyDesigns = (state) => (
  filter(getDesigns(state), {
    project: `${state.projects.current}`,
    designer: `${getMe(state).id}`
  })
)

export const isCurrentDesignExists = (state) => !isEmpty(state.designs.current)
