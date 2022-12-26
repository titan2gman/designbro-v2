import { combineReducers } from 'redux'

// reducers

const ids = (state = [], action) => {
  switch (action.type) {
  case 'PORTFOLIO_LOAD_SUCCESS':
  case 'EXPERIENCE_UPDATE_SUCCESS':
    return action.payload.results.portfolioWorks || []
  default:
    return state
  }
}

const loading = (state = false, action) => {
  switch (action.type) {
  case 'PORTFOLIO_LOAD_START':
    return true
  case 'PORTFOLIO_LOAD_SUCCESS':
  case 'PORTFOLIO_LOAD_FAILURE':
    return false
  default:
    return state
  }
}

export default combineReducers({
  ids, loading
})

// helpers

const getPortfolioWorks = (state) => (
  state.portfolioWorks.ids.map((id) =>
    state.entities.portfolioWorks[id]
  )
)

export { getPortfolioWorks }
