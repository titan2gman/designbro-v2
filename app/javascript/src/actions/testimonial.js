import api from '@utils/api'

export const loadTestimonial = () => (
  api.get({
    endpoint: '/api/v1/public/testimonial',
    normalize: true,

    types: [
      'TESTIMONIAL_LOAD_REQUEST',
      'TESTIMONIAL_LOAD_SUCCESS',
      'TESTIMONIAL_LOAD_FAILURE'
    ]
  })
)
