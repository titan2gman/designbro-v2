import { combineReducers } from 'redux'

const IN_PROGRESS = 'IN_PROGRESS'
const PERFORMED = 'PERFORMED'

//  reducers

const createPortfolioRequestStatus = (state = null, action) => {
  switch (action.type) {
  case 'PORTFOLIO_CREATE_REQUEST':
    return IN_PROGRESS
  case 'PORTFOLIO_CREATE_SUCCESS':
  case 'PORTFOLIO_CREATE_FAILURE':
    return PERFORMED
  default:
    return state
  }
}

export default combineReducers({
  createPortfolioRequestStatus
})

// helpers

export const canSendCreatePortfolioRequest = (state) => (
  state.portfolios.createPortfolioRequestStatus !== IN_PROGRESS
)
