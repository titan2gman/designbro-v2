import _ from 'lodash'
import axios from 'axios'

import { history } from '../history'

import { persistHeaders, extractFromHeaders } from '@utils/auth'

import { bugsnagClient } from '../bugsnag'

const makeAction = (method) => ({ endpoint: url, body: data, types }) => (dispatch, getState) => {
  const headers = getState().authHeaders

  dispatch(typeof types[0] === 'string' ? { type: types[0] } : types[0])

  return axios({ method, url, headers, data })
    .then((response) => {
      const meta = extractFromHeaders(response.headers)

      persistHeaders(meta)

      const action = {
        type: types[1],
        payload: response.data,
        meta
      }

      dispatch(action)

      return action
    }).catch((error) => {
      bugsnagClient.leaveBreadcrumb('Server error', {
        serverError: error
      })

      dispatch({ type: types[2] })

      return { error: true, payload: error.response || error }
    })
}

const methods = ['get', 'post', 'put', 'patch', 'delete', 'head']

export default _.transform(methods, (result, method) => {
  result[method] = makeAction(method)
}, {})
