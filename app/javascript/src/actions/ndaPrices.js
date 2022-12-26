import api from '@utils/api'

export const LOAD_NDA_PRICES_REQUEST = 'LOAD_NDA_PRICES_REQUEST'
export const LOAD_NDA_PRICES_SUCCESS = 'LOAD_NDA_PRICES_SUCCESS'
export const LOAD_NDA_PRICES_FAILURE = 'LOAD_NDA_PRICES_FAILURE'

const loadNdaPrices = () => api.get({
  endpoint: '/api/v1/nda_prices',
  normalize: true,

  types: [
    LOAD_NDA_PRICES_REQUEST,
    LOAD_NDA_PRICES_SUCCESS,
    LOAD_NDA_PRICES_FAILURE
  ]
})

export { loadNdaPrices }
