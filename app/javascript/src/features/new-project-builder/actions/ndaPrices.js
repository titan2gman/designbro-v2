import api from '@utils/apiV2'

export const LOAD_NDA_PRICES_REQUEST = 'new-project-builder/LOAD_NDA_PRICES_REQUEST'
export const LOAD_NDA_PRICES_SUCCESS = 'new-project-builder/LOAD_NDA_PRICES_SUCCESS'
export const LOAD_NDA_PRICES_FAILURE = 'new-project-builder/LOAD_NDA_PRICES_FAILURE'

export const loadNdaPrices = () => api.get({
  endpoint: '/api/v2/nda_prices',
  types: [LOAD_NDA_PRICES_REQUEST, LOAD_NDA_PRICES_SUCCESS, LOAD_NDA_PRICES_FAILURE]
})
