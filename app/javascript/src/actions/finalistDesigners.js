import api from '@utils/api'

export const FINALIST_DESIGNERS_LOAD_REQUEST = 'FINALIST_DESIGNERS_LOAD_REQUEST'
export const FINALIST_DESIGNERS_LOAD_SUCCESS = 'FINALIST_DESIGNERS_LOAD_SUCCESS'
export const FINALIST_DESIGNERS_LOAD_FAILURE = 'FINALIST_DESIGNERS_LOAD_FAILURE'

export const loadFinalistDesigners = () => api.get({
  endpoint: '/api/v1/clients/spots/finalists',
  normalize: true,

  types: [
    FINALIST_DESIGNERS_LOAD_REQUEST,
    FINALIST_DESIGNERS_LOAD_SUCCESS,
    FINALIST_DESIGNERS_LOAD_FAILURE
  ]
})
