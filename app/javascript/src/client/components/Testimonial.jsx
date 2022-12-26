import React from 'react'
import PropTypes from 'prop-types'

const Testimonial = ({ testimonial }) => (
  <div>
    {!!testimonial && (
      <div className="prjb-comment">
        <p className="prjb-comment__title">{testimonial.header}</p>
        <p className="prjb-comment__text">{testimonial.body}</p>
        <p className="prjb-comment__author">
          <span className="prjb-comment__author-stars-filled">{'★'.repeat(testimonial.rating)}</span>
          <span className="prjb-comment__author-stars-blank">{'★'.repeat(5 - testimonial.rating)}</span>
          {testimonial.credential} - {testimonial.company}
        </p>
      </div>
    )}
  </div>
)

Testimonial.propTypes = {
  testimonial: PropTypes.object
}

export default Testimonial
