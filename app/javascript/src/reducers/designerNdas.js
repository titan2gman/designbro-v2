import { combineReducers } from 'redux'

// reducers:

const inProgress = (state = true, action) => {
  switch (action.type) {
  case 'LOAD_DESIGNER_NDAS_REQUEST':
    return true
  case 'LOAD_DESIGNER_NDAS_SUCCESS':
  case 'LOAD_DESIGNER_NDAS_FAILURE':
    return false
  default:
    return state
  }
}

const designerNdasIds = (state = [], action) => {
  switch (action.type) {
  case 'LOAD_DESIGNER_NDAS_SUCCESS':
    return action.payload.results.designerNdas || []
  default:
    return state
  }
}

const designerNdasPager = (state = { currentPage: 0, totalPages: 0 }, action) => {
  switch (action.type) {
  case 'LOAD_DESIGNER_NDAS_SUCCESS':
    return action.payload.meta
  case 'DESIGNER_NDAS_CHANGE_PAGE':
    return { ...state, currentPage: action.page }
  default:
    return state
  }
}

export default combineReducers({
  ids: designerNdasIds,
  pager: designerNdasPager,
  inProgress
})
