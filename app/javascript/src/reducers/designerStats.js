import { combineReducers } from 'redux'

const loaded = (state = false, action) => {
  switch (action.type) {
  case 'DESIGNER_STATS_LOAD_SUCCESS':
  case 'DESIGNER_STATS_UPDATED':
    return true
  case 'SIGN_OUT_SUCCESS':
  case 'SIGN_OUT_FAILURE':
    return false
  default:
    return state
  }
}

const id = (state = null, action) => {
  switch (action.type) {
  case 'VALIDATE_AUTH_SUCCESS':
  case 'SIGN_IN_EMAIL_SUCCESS':
  case 'DESIGNER_UPDATE_SUCCESS':
  case 'CLIENT_UPDATE_SUCCESS':
  case 'USER_UPDATE_SUCCESS':
    return action.payload.data.id
  case 'SIGN_OUT_SUCCESS':
  case 'SIGN_OUT_FAILURE':
    return null
  default:
    return state
  }
}

export default combineReducers({
  loaded,
  id
})

// helpers

export const getDesignerStatsLoaded = (state) => (
  state.designerStats.loaded
)

export const getDesignerStats = (state) => {
  if (getDesignerStatsLoaded(state)) {
    return state.entities.designerStats[state.designerStats.id]
  }
}

export const getAvailableForPayout = (state) => (
  getDesignerStatsLoaded(state) && getDesignerStats(state).availableForPayout
)
