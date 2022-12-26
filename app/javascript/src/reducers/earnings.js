import { combineReducers } from 'redux'

const ids = (state = [], action) => {
  switch (action.type) {
  case 'EARNINGS_LOAD_SUCCESS':
    return action.payload.results.earnings || []
  default:
    return state
  }
}

export const getEarnings = (state) => (
  state.earnings.ids.map((id) =>
    state.entities.earnings[id]
  )
)

const pager = (state = { currentPage: 0, totalPages: 0 }, action) => {
  switch (action.type) {
  case 'EARNINGS_LOAD_SUCCESS':
    return action.payload.meta
  case 'EARNINGS_CHANGE_PAGE':
    return { ...state, currentPage: action.page }
  default:
    return state
  }
}

export default combineReducers({
  ids, pager
})
