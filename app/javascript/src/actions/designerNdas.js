import api from '@utils/api'

import queryString from 'query-string'

export const loadDesignerNdas = (params = {}) => {
  const serializedParams = queryString.stringify(params)

  const endpoint = `/api/v1/designer_ndas?${serializedParams}`

  const types = [
    'LOAD_DESIGNER_NDAS_REQUEST',
    'LOAD_DESIGNER_NDAS_SUCCESS',
    'LOAD_DESIGNER_NDAS_FAILURE'
  ]

  return api.get({ endpoint, types, normalize: true })
}

export const pureLoadDesignerNdas = (params) =>
  (dispatch, getState) => {
    const page = getState().designerNdas
      .pager.currentPage

    dispatch(loadDesignerNdas({ ...params, page }))
  }

export const createDesignerNda = (project) => api.post({
  endpoint: '/api/v1/designer_ndas',
  body: { nda_id: project.nda.id },
  normalize: true,

  types: [
    'CREATE_DESIGNER_NDA_REQUEST',
    'CREATE_DESIGNER_NDA_SUCCESS',
    'CREATE_DESIGNER_NDA_FAILURE'
  ]
})

export const changeDesignerNdasPage = (page) => ({
  type: 'DESIGNER_NDAS_CHANGE_PAGE', page
})
