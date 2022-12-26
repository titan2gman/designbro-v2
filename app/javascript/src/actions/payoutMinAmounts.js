import api from '@utils/api'

export const loadPayoutMinAmounts = () => api.get({
  endpoint: '/api/v1/payout_min_amounts',
  types: [
    'PAYOUT_MIN_AMOUNTS_LOAD_REQUEST',
    'PAYOUT_MIN_AMOUNTS_LOAD_SUCCESS',
    'PAYOUT_MIN_AMOUNTS_LOAD_FAILURE'
  ],
  normalize: true
})
