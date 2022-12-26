import api from '@utils/apiV2'

export const LOAD_BRAND_EXAMPLES_REQUEST = 'new-project-builder/LOAD_BRAND_EXAMPLES_REQUEST'
export const LOAD_BRAND_EXAMPLES_SUCCESS = 'new-project-builder/LOAD_BRAND_EXAMPLES_SUCCESS'
export const LOAD_BRAND_EXAMPLES_FAILURE = 'new-project-builder/LOAD_BRAND_EXAMPLES_FAILURE'

export const loadBrandExamples = () => api.get({
  endpoint: '/api/v2/brand_examples',
  types: [LOAD_BRAND_EXAMPLES_REQUEST, LOAD_BRAND_EXAMPLES_SUCCESS, LOAD_BRAND_EXAMPLES_FAILURE]
})
