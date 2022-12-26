import api from '@utils/api'

export const LOAD_PRODUCTS_REQUEST = 'LOAD_PRODUCTS_REQUEST'
export const LOAD_PRODUCTS_SUCCESS = 'LOAD_PRODUCTS_SUCCESS'
export const LOAD_PRODUCTS_FAILURE = 'LOAD_PRODUCTS_FAILURE'

export const loadProducts = () => api.get({
  endpoint: '/api/v1/public/products',
  normalize: true,

  types: [
    LOAD_PRODUCTS_REQUEST,
    LOAD_PRODUCTS_SUCCESS,
    LOAD_PRODUCTS_FAILURE
  ]
})
