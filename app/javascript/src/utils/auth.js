import transform from 'lodash/transform'

import queryString from 'query-string'
import Cookie from 'js-cookie'

const headersList = ['access-token', 'client', 'uid', 'token-type']

const getCookieHeaders = () =>
  headersList.reduce((o, h) => {
    o[h] = Cookie.get(h)
    return o
  }, {})

export const persistHeadersInCookies = (headers) => (
  headersList.forEach((headerName) =>
    Cookie.set(headerName, headers[headerName])
  )
)

const getLocationHeaders = () => {
  const query = queryString.parse(document.location.search)
  if (query.token && query.client_id && query.uid) {
    return {
      'access-token': query.token,
      'client': query.client_id,
      'uid': query.uid,
      'token-type': 'bearer'
    }
  } else {
    return {}
  }
}

export const cleanHeadersInCookies = () => (
  headersList.forEach((headerName) =>
    Cookie.remove(headerName)
  )
)

export const extractFromHeaders = (headers) => (
  transform(headersList, (result, headerName) => {
    result[headerName] = headers[headerName]
  }, {})
)

export const persistHeaders = persistHeadersInCookies
export const cleanHeaders = cleanHeadersInCookies

export const getHeaders = () => {
  const headers = {
    ...getCookieHeaders(),
    ...getLocationHeaders()
  }

  persistHeaders(headers)
  return headers
}

export const getRedirectPath = (data) => {
  if (data.attributes.god === true) {
    return '/g'
  }

  if (data.attributes.userType === 'designer') {
    return '/d'
  }
}
