import api from '@utils/apiV2'

export const LOAD_PRODUCTS_REQUEST = 'new-project-builder/LOAD_PRODUCTS_REQUEST'
export const LOAD_PRODUCTS_SUCCESS = 'new-project-builder/LOAD_PRODUCTS_SUCCESS'
export const LOAD_PRODUCTS_FAILURE = 'new-project-builder/LOAD_PRODUCTS_FAILURE'

export const loadProducts = () => api.get({
  endpoint: '/api/v2/products',
  types: [LOAD_PRODUCTS_REQUEST, LOAD_PRODUCTS_SUCCESS, LOAD_PRODUCTS_FAILURE]
})
