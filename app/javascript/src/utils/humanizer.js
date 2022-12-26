
import startCase from 'lodash/startCase'
import capitalize from 'lodash/capitalize'

export const humanizeNdaTypeName = (ndaType) => {
  return `${capitalize(ndaType)} NDA`
}

export const humanizeProjectTypeName = (productKey) => {
  return `${productKey.split('-').map(capitalize).join(' ')} Design`
}

export const humanizePrice = (price) => {
  const sign = price < 0 ? '-' : ''
  return `${sign} $${Math.abs(price).toFixed(2)}`
}

export const humanizePayoutState = (state) => {
  return capitalize(startCase(state))
}
