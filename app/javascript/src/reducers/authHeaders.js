import { getHeaders } from '@utils/auth'

const initialState = getHeaders()

const reducer = (state = initialState, action) => {
  switch (action.type) {
  case 'JOIN_EMAIL_SUCCESS':
  case 'SIGN_IN_EMAIL_SUCCESS':
  case 'USER_UPDATE_SUCCESS':
  case 'DESIGNER_UPDATE_SUCCESS':
  case 'CLIENT_UPDATE_SUCCESS':
    return action.meta
  case 'SIGN_OUT_REQUEST':
    return {}
  default:
    return state
  }
}

export default reducer
