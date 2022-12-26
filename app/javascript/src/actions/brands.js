import api from '@utils/api'
import queryString from 'query-string'

import { getBrandsPager } from '@reducers/brands'

export const BRANDS_LOAD_REQUEST = 'BRANDS_LOAD_REQUEST'
export const BRANDS_LOAD_SUCCESS = 'BRANDS_LOAD_SUCCESS'
export const BRANDS_LOAD_FAILURE = 'BRANDS_LOAD_FAILURE'

export const loadAllBrands = () => api.get({
  endpoint: '/api/v1/brands/all',
  normalize: true,

  types: [
    BRANDS_LOAD_REQUEST,
    BRANDS_LOAD_SUCCESS,
    BRANDS_LOAD_FAILURE
  ]
})

const pureLoadBrands = (params) => api.get({
  endpoint: `/api/v1/brands?${queryString.stringify(params)}`,
  normalize: true,

  types: [
    BRANDS_LOAD_REQUEST,
    BRANDS_LOAD_SUCCESS,
    BRANDS_LOAD_FAILURE
  ]
})

export const loadBrands = (params) => (dispatch, getState) => {
  const brandsPager = getBrandsPager(getState())
  const currentBrandsPage = brandsPager.current

  dispatch(pureLoadBrands({ ...params, page: currentBrandsPage }))
}

export const BRAND_LOAD_REQUEST = 'BRAND_LOAD_REQUEST'
export const BRAND_LOAD_SUCCESS = 'BRAND_LOAD_SUCCESS'
export const BRAND_LOAD_FAILURE = 'BRAND_LOAD_FAILURE'

export const loadBrand = (id) => api.get({
  endpoint: `/api/v1/brands/${id}`,
  normalize: true,

  types: [
    BRAND_LOAD_REQUEST,
    BRAND_LOAD_SUCCESS,
    BRAND_LOAD_FAILURE
  ]
})

export const BRANDS_CHANGE_PAGE = 'BRANDS_CHANGE_PAGE'

export const changePage = (page) => {
  return {
    type: BRANDS_CHANGE_PAGE,
    page: page
  }
}
