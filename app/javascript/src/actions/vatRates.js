import api from '@utils/api'

export const LOAD_VAT_RATES_REQUEST = 'LOAD_VAT_RATES_REQUEST'
export const LOAD_VAT_RATES_SUCCESS = 'LOAD_VAT_RATES_SUCCESS'
export const LOAD_VAT_RATES_FAILURE = 'LOAD_VAT_RATES_FAILURE'

const loadVatRates = () => api.get({
  endpoint: '/api/v1/public/vat_rates',
  normalize: true,

  types: [
    LOAD_VAT_RATES_REQUEST,
    LOAD_VAT_RATES_SUCCESS,
    LOAD_VAT_RATES_FAILURE
  ]
})

export { loadVatRates }
