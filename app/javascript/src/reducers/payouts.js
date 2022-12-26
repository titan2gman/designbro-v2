import { combineReducers } from 'redux'

const ids = (state = [], action) => {
  switch (action.type) {
  case 'PAYOUTS_CREATE_SUCCESS':
  case 'PAYOUTS_LOAD_SUCCESS':
    return action.payload.results.payouts || []
  default:
    return state
  }
}

export const getPayouts = (state) => (
  state.payouts.ids.map((id) =>
    state.entities.payouts[id]
  )
)

const pager = (state = { currentPage: 0, totalPages: 0 }, action) => {
  switch (action.type) {
  case 'PAYOUTS_LOAD_SUCCESS':
    return action.payload.meta
  case 'PAYOUTS_CHANGE_PAGE':
    return { ...state, currentPage: action.page }
  default:
    return state
  }
}

export default combineReducers({
  ids, pager
})
