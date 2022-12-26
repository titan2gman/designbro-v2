import { combineReducers } from 'redux'

// reducers

const initialState = {
  me: {},
  loading: false,
  authFormVisible: false
}

const me = (state = initialState.me, action) => {
  switch (action.type) {
  case 'INCREMENT_ACTIVE_SPOTS_COUNT': {
    return { ...state, activeSpotsCount: state.activeSpotsCount + 1 }
  }
  case 'PAYOUTS_CREATE_SUCCESS':
    return { ...state, availableForPayout: 0 }
  case 'VALIDATE_AUTH_SUCCESS':
  case 'SIGN_IN_EMAIL_SUCCESS':
  case 'DESIGNER_UPDATE_SUCCESS':
  case 'CLIENT_UPDATE_SUCCESS':
  case 'USER_UPDATE_SUCCESS':
    const data = action.payload.data
    return { ...state, id: data.id, ...data.attributes }
  case 'EXPERIENCE_UPDATE_SUCCESS':
    const id = state.id

    const designers = action
      .payload.entities.designers

    const designer = designers[id]

    return { ...state, id, ...designer }
  case 'SIGN_OUT_SUCCESS':
  case 'SIGN_OUT_FAILURE':
    return initialState.me
  case 'PORTFOLIO_UPLOADED':
    return { ...state, portfolioUploaded: true }
  default:
    return state
  }
}

const authFormVisible = (state = initialState.authFormVisible, action) => {
  switch (action.type) {
  case 'SHOW_AUTH_FORM':
  case 'VALIDATE_AUTH_FAILURE':
    return true
  case 'HIDE_AUTH_FORM':
  case 'SIGN_OUT_SUCCESS':
  case 'SIGN_OUT_FAILURE':
    return false
  default:
    return state
  }
}

const loading = (state = initialState.loading, action) => {
  switch (action.type) {
  case 'USER_UPDATE_REQUEST':
  case 'JOIN_EMAIL_REQUEST':
    return true
  case 'USER_UPDATE_SUCCESS':
  case 'USER_UPDATE_FAILURE':
  case 'JOIN_EMAIL_SUCCESS':
  case 'JOIN_EMAIL_FAILURE':
    return false
  case 'SIGN_OUT_SUCCESS':
  case 'SIGN_OUT_FAILURE':
    return initialState.authFormVisible
  default:
    return state
  }
}

export default combineReducers({
  me,
  loading,
  authFormVisible
})

// helpers

const getLongName = (state) => {
  if (state.firstName && state.lastName) {
    return [state.firstName, state.lastName]
  } else if (state.displayName) {
    return [state.displayName]
  } else {
    return [state.email]
  }
}

export const getMe = (state) => state.me.me

export const isMeLoading = (state) => state.me.loading
export const isAuthenticated = state => !!getMe(state).id
export const isAuthFormVisible = state => state.me.authFormVisible

export const isBrandIdentityApproved = state => getMe(state).brandIdentityState === 'approved'
export const isPackagingApproved = state => getMe(state).packagingState === 'approved'

export { getLongName }
