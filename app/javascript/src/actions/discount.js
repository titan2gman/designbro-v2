import api from '@utils/api'

export const DISCOUNT_CHECK_REQUEST = 'DISCOUNT_CHECK_REQUEST'
export const DISCOUNT_CHECK_SUCCESS = 'DISCOUNT_CHECK_SUCCESS'
export const DISCOUNT_CHECK_FAILURE = 'DISCOUNT_CHECK_FAILURE'

export const checkDiscount = (value) => api.get({
  endpoint: `/api/v1/discounts/${value}`,

  types: [
    DISCOUNT_CHECK_REQUEST,
    DISCOUNT_CHECK_SUCCESS,
    DISCOUNT_CHECK_FAILURE
  ],

  normalize: true
})
