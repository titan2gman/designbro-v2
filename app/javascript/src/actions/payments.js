import api from '@utils/api'

import serializeParams from '@utils/serializeParams'

const pureLoadPayments = (params) =>
  api.get({
    endpoint: `/api/v1/payments?${serializeParams(params)}`,
    types: [
      'PAYMENTS_LOAD_REQUEST',
      'PAYMENTS_LOAD_SUCCESS',
      'PAYMENTS_LOAD_FAILURE'
    ],
    normalize: true
  })

export const loadPayments = (params) => {
  return (dispatch, getState) => {
    params = {
      page: getState().payments.pager.currentPage,
      ...params
    }
    dispatch(pureLoadPayments(params))
  }
}

export const changePage = (page) => {
  return {
    type: 'PAYMENTS_CHANGE_PAGE',
    page: page
  }
}
