import api from '@utils/apiV2'

export const LOAD_VAT_RATES_REQUEST = 'new-project-builder/LOAD_VAT_RATES_REQUEST'
export const LOAD_VAT_RATES_SUCCESS = 'new-project-builder/LOAD_VAT_RATES_SUCCESS'
export const LOAD_VAT_RATES_FAILURE = 'new-project-builder/LOAD_VAT_RATES_FAILURE'

export const loadVatRates = () => api.get({
  endpoint: '/api/v2/vat_rates',
  types: [LOAD_VAT_RATES_REQUEST, LOAD_VAT_RATES_SUCCESS, LOAD_VAT_RATES_FAILURE]
})
