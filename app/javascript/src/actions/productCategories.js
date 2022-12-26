import api from '@utils/api'

export const LOAD_PRODUCT_CATEGORIES_REQUEST = 'LOAD_PRODUCT_CATEGORIES_REQUEST'
export const LOAD_PRODUCT_CATEGORIES_SUCCESS = 'LOAD_PRODUCT_CATEGORIES_SUCCESS'
export const LOAD_PRODUCT_CATEGORIES_FAILURE = 'LOAD_PRODUCT_CATEGORIES_FAILURE'

export const loadProductCategories = () => api.get({
  endpoint: '/api/v1/public/product_categories',
  normalize: true,

  types: [
    LOAD_PRODUCT_CATEGORIES_REQUEST,
    LOAD_PRODUCT_CATEGORIES_SUCCESS,
    LOAD_PRODUCT_CATEGORIES_FAILURE
  ]
})
