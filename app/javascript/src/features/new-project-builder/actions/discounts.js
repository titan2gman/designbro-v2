import api from '@utils/apiV2'

export const LOAD_DISCOUNT_REQUEST = 'new-project-builder/LOAD_DISCOUNT_REQUEST'
export const LOAD_DISCOUNT_SUCCESS = 'new-project-builder/LOAD_DISCOUNT_SUCCESS'
export const LOAD_DISCOUNT_FAILURE = 'new-project-builder/LOAD_DISCOUNT_FAILURE'

export const loadDiscount = (discountCode) => api.get({
  endpoint: `/api/v2/discounts/${discountCode}`,
  types: [LOAD_DISCOUNT_REQUEST, LOAD_DISCOUNT_SUCCESS, LOAD_DISCOUNT_FAILURE]
})
