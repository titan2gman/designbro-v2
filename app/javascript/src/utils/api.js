import axios from 'axios'
import { DISCOUNT_CHECK_FAILURE } from '@actions/discount'
import { PROJECT_LOAD_FAILURE } from '@actions/projectBuilder'

import transform from 'lodash/transform'
import _normalize from '@utils/normalizer'
import { history } from '../history'

import { getMe } from '@reducers/me'
import { persistHeaders, extractFromHeaders } from '@utils/auth'

import { bugsnagClient } from '../bugsnag'

const getRedirectUri = (status) => {
  switch (status) {
  case 401:
  case 403:
    return '/login'
  case 404:
    return '/errors/404'
  case 500:
    return '/errors/500'
  default:
    return null
  }
}

const makeAction = (method) => ({ endpoint: url, body: data, normalize, types }) => (dispatch, getState) => {
  const headers = getState().authHeaders

  dispatch(typeof types[0] === 'string' ? { type: types[0] } : types[0])

  return axios({ method, url, headers, data })
    .then((response) => {
      const payload = normalize ? _normalize(response.data) : response.data
      const meta = extractFromHeaders(response.headers)

      persistHeaders(meta)

      const action = { type: types[1], payload, meta }

      dispatch(action)

      return action
    }).catch((error) => {
      bugsnagClient.leaveBreadcrumb('Server error', {
        serverError: error
      })

      dispatch({ type: types[2] })

      if (error.response) {
        if (getMe(getState()).id || types[2] === PROJECT_LOAD_FAILURE) {
          const { status } = error.response
          const uri = getRedirectUri(status)

          // hotfix, need to refactor for discount check
          if (uri && types[2] !== DISCOUNT_CHECK_FAILURE) {
            history.push(uri)
          }
        }
      }

      return { error: true, payload: error.response || error }
    })
}

const methods = ['get', 'post', 'put', 'patch', 'delete', 'head']

export default transform(methods, (result, method) => {
  result[method] = makeAction(method)
}, {})
