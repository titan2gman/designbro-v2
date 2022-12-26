import {
  DISCOUNT_CHECK_REQUEST,
  DISCOUNT_CHECK_SUCCESS,
  DISCOUNT_CHECK_FAILURE
} from '@actions/discount'

const initialState = {
  inProgress: false
}

export default (state = initialState, action) => {
  switch (action.type) {
  case DISCOUNT_CHECK_SUCCESS:
    return {
      ...state,
      inProgress: false
    }
  case DISCOUNT_CHECK_REQUEST:
    return {
      ...state,
      inProgress: true
    }
  case DISCOUNT_CHECK_FAILURE:
    return {
      ...state,
      inProgress: false
    }
  default:
    return state
  }
}
