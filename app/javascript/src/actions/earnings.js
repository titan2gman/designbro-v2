import api from '@utils/api'

import serializeParams from '@utils/serializeParams'

const pureLoadEarnings = (params) =>
  api.get({
    endpoint: `/api/v1/earnings?${serializeParams(params)}`,
    types: [
      'EARNINGS_LOAD_REQUEST',
      'EARNINGS_LOAD_SUCCESS',
      'EARNINGS_LOAD_FAILURE'
    ],
    normalize: true
  })

export const loadEarnings = (params) => {
  return (dispatch, getState) => {
    params = {
      page: getState().earnings.pager.currentPage,
      ...params
    }
    dispatch(pureLoadEarnings(params))
  }
}

export const changePage = (page) => {
  return {
    type: 'EARNINGS_CHANGE_PAGE',
    page: page
  }
}
