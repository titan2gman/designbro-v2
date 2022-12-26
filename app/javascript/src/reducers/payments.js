import { combineReducers } from 'redux'

// reducers

const ids = (state = [], action) => {
  switch (action.type) {
  case 'PAYMENTS_LOAD_SUCCESS':
    return action.payload.results.payments || []
  default:
    return state
  }
}

const loading = (state = false, action) => {
  switch (action.type) {
  case 'PAYMENTS_LOAD_REQUEST':
    return true
  case 'PAYMENTS_LOAD_SUCCESS':
  case 'PAYMENTS_LOAD_FAILURE':
    return false
  default:
    return state
  }
}

const pager = (state = { currentPage: 0, totalPages: 0 }, action) => {
  switch (action.type) {
  case 'PAYMENTS_LOAD_SUCCESS':
    return action.payload.meta
  case 'PAYMENTS_CHANGE_PAGE':
    return { ...state, currentPage: action.page }
  default:
    return state
  }
}

export default combineReducers({
  ids, loading, pager
})

// helpers

export const getPayments = (state) => (
  state.payments.ids.map((id) =>
    state.entities.payments[id]
  )
)

export const getLoading = (state) => (
  state.payments.loading
)
