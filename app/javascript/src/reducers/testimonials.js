import { combineReducers } from 'redux'
import values from 'lodash/values'
import first from 'lodash/first'

const loaded = (state = false, action) => {
  switch (action.type) {
  case 'TESTIMONIAL_LOAD_SUCCESS':
  case 'TESTIMONIAL_LOAD_FAILURE':
    return true
  case 'TESTIMONIAL_LOAD_REQUEST':
    return false
  default:
    return state
  }
}

export default combineReducers({ loaded })

export const getTestimonialLoaded = (state) => (
  state.testimonials.loaded
)

export const getTestimonial = ({ entities }) => (
  first(values(entities.testimonials))
)
