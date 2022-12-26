import api from '@utils/api'

import queryString from 'query-string'

export const createReview = (review) => (
  api.post({
    endpoint: '/api/v1/reviews',
    normalize: true,
    body: { review },

    types: [
      'REVIEW_CREATE_REQUEST',
      'REVIEW_CREATE_SUCCESS',
      'REVIEW_CREATE_FAILURE'
    ]
  })
)

export const loadReviews = (params) => (
  api.get({
    endpoint: `/api/v1/reviews?${
      queryString.stringify(
        params
      )
    }`,

    normalize: true,

    types: [
      'REVIEW_LOAD_REQUEST',
      'REVIEW_LOAD_SUCCESS',
      'REVIEW_LOAD_FAILURE'
    ]
  })
)

export const loadReviewsByDesignerId = (designerId) => (
  loadReviews({ designer_id_eq: designerId })
)
