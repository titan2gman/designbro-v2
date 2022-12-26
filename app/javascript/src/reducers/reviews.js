import find from 'lodash/find'
import values from 'lodash/values'

import { combineReducers } from 'redux'

const inProgress = (state = true, action) => {
  switch (action.type) {
  case 'REVIEW_LOAD_REQUEST':
    return true
  case 'REVIEW_LOAD_SUCCESS':
  case 'REVIEW_LOAD_FAILURE':
    return false
  default:
    return state
  }
}

export default combineReducers({
  inProgress
})

export const getReviews = (state) => (
  values(state.entities.reviews)
)

export const getReviewByClientAndDesign = (state, clientId, designId) => {
  return  find(getReviews(state), { design: designId, client: clientId })
}
