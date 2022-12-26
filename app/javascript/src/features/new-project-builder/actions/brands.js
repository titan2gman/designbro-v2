import api from '@utils/apiV2'

export const LOAD_BRANDS_REQUEST = 'new-project-builder/LOAD_BRANDS_REQUEST'
export const LOAD_BRANDS_SUCCESS = 'new-project-builder/LOAD_BRANDS_SUCCESS'
export const LOAD_BRANDS_FAILURE = 'new-project-builder/LOAD_BRANDS_FAILURE'

export const loadBrands = () => api.get({
  endpoint: '/api/v2/brands',
  types: [LOAD_BRANDS_REQUEST, LOAD_BRANDS_SUCCESS, LOAD_BRANDS_FAILURE]
})
