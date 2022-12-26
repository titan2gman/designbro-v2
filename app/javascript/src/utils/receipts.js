import map from 'lodash/map'

const toQueryPart = (value, key) => {
  const _key = encodeURIComponent(key)
  const _value = encodeURIComponent(value)

  return `${_key}=${_value}`
}

export const generateDownloadUrl = (authHeaders, paymentId) => {
  const query = map(authHeaders, toQueryPart).join('&')
  return `/receipts/${paymentId}.pdf?${query}`
}
