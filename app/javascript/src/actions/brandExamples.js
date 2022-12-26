import api from '@utils/api'

export const LOAD_BRAND_EXAMPLES_REQUEST = 'LOAD_BRAND_EXAMPLES_REQUEST'
export const LOAD_BRAND_EXAMPLES_SUCCESS = 'LOAD_BRAND_EXAMPLES_SUCCESS'
export const LOAD_BRAND_EXAMPLES_FAILURE = 'LOAD_BRAND_EXAMPLES_FAILURE'

export const loadBrandExamples = () => api.get({
  endpoint: '/api/v1/public/brand_examples',
  normalize: true,
  types: [
    LOAD_BRAND_EXAMPLES_REQUEST,
    LOAD_BRAND_EXAMPLES_SUCCESS,
    LOAD_BRAND_EXAMPLES_FAILURE
  ]
})
