import api from '@utils/api'

export const LOAD_ADDITIONAL_DESIGN_PRICES_REQUEST = 'LOAD_ADDITIONAL_DESIGN_PRICES_REQUEST'
export const LOAD_ADDITIONAL_DESIGN_PRICES_SUCCESS = 'LOAD_ADDITIONAL_DESIGN_PRICES_SUCCESS'
export const LOAD_ADDITIONAL_DESIGN_PRICES_FAILURE = 'LOAD_ADDITIONAL_DESIGN_PRICES_FAILURE'

const loadAdditionalDesignPrices = () => api.get({
  endpoint: '/api/v1/public/additional_design_prices',
  normalize: true,

  types: [
    LOAD_ADDITIONAL_DESIGN_PRICES_REQUEST,
    LOAD_ADDITIONAL_DESIGN_PRICES_SUCCESS,
    LOAD_ADDITIONAL_DESIGN_PRICES_FAILURE
  ]
})

export { loadAdditionalDesignPrices }
