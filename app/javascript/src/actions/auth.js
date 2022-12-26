import { cleanHeadersInCookies } from '@utils/auth'
import api from '@utils/api'
import { history } from '../history'

export const signupEmail = (userType, data) =>
  api.post({
    endpoint: '/api/v1/auth',
    body: { ...data, user_type: userType },
    types: ['JOIN_EMAIL_REQUEST', 'JOIN_EMAIL_SUCCESS', 'JOIN_EMAIL_FAILURE']
  })

export const signinEmail = (data) => api.post({
  endpoint: '/api/v1/auth/sign_in',
  body: data,

  types: [
    'SIGN_IN_EMAIL_REQUEST',
    'SIGN_IN_EMAIL_SUCCESS',
    'SIGN_IN_EMAIL_FAILURE'
  ]
})

export const signout = () => api.delete({
  endpoint: '/api/v1/auth/sign_out',

  types: [
    'SIGN_OUT_REQUEST',
    'SIGN_OUT_SUCCESS',
    'SIGN_OUT_FAILURE'
  ]
})

export const confirmationResend = (data) =>
  api.post({
    endpoint: '/api/v1/auth/confirmation',
    body: data,
    types: ['CONFIRMATION_RESEND_REQUEST', 'CONFIRMATION_RESEND_SUCCESS', 'CONFIRMATION_RESEND_FAILURE']
  })

export const restorePassword = (data) =>
  api.post({
    endpoint: 'api/v1/auth/password',
    body: data,
    types: ['PASSWORD_RESTORE_REQUEST', 'PASSWORD_RESTORE_SUCCESS', 'PASSWORD_RESTORE_FAILURE']
  })

export const changePassword = ({ password, currentPassword }) =>
  api.put({
    endpoint: '/api/v1/auth/password',
    body: { password, passwordConfirmation: password, currentPassword },
    types: ['PASSWORD_CHANGE_REQUEST', 'PASSWORD_CHANGE_SUCCESS', 'PASSWORD_CHANGE_FAILURE']
  })

export const validateResetToken = (token) =>
  api.get({
    endpoint: `/api/v1/auth/password/validate?token=${token}`,
    types: [
      'VALIDATE_PASSWORD_RESET_TOKEN_REQUEST',
      'VALIDATE_PASSWORD_RESET_TOKEN_SUCCESS',
      'VALIDATE_PASSWORD_RESET_TOKEN_FAILURE'
    ]
  })

export const resetPassword = (token, { password }) =>
  api.put({
    endpoint: '/api/v1/auth/password/reset',
    body: { token, password, passwordConfirmation: password },

    types: [
      'PASSWORD_RESET_REQUEST',
      'PASSWORD_RESET_SUCCESS',
      'PASSWORD_RESET_FAILURE'
    ]
  })

export const signOutAndCleanHeaders = () => (dispatch) => {
  dispatch(signout()).then(() => {
    if (window.Intercom) {
      window.Intercom('shutdown')
    }
    cleanHeadersInCookies()
    history.push('/login')
  })
}
