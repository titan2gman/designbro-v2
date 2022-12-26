import first from 'lodash/first'
import values from 'lodash/values'

export const getPayoutMinAmount = ({ entities }) => (
  first(values(entities.payoutMinAmounts)) || {}
)
