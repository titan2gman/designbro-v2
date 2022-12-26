import api from '@utils/api'
import serializeParams from '@utils/serializeParams'

export const create = (params) =>
  api.post({
    endpoint: '/api/v1/payouts',
    body: params,
    types: [
      'PAYOUTS_CREATE_REQUEST',
      'PAYOUTS_CREATE_SUCCESS',
      'PAYOUTS_CREATE_FAILURE'
    ],
    normalize: true
  })

const pureLoadPayouts = (params) =>
  api.get({
    endpoint: `/api/v1/payouts?${serializeParams(params)}`,
    types: [
      'PAYOUTS_LOAD_REQUEST',
      'PAYOUTS_LOAD_SUCCESS',
      'PAYOUTS_LOAD_FAILURE'
    ],
    normalize: true
  })

export const loadPayouts = (params) => {
  return (dispatch, getState) => {
    params = {
      page: getState().payouts.pager.currentPage,
      ...params
    }
    dispatch(pureLoadPayouts(params))
  }
}

export const changePage = (page) => {
  return {
    type: 'PAYOUTS_CHANGE_PAGE',
    page: page
  }
}
