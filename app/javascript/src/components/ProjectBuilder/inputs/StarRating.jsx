import React from 'react'
import Rating from 'react-rating'
import PropTypes from 'prop-types'

const StarRating = ({ value, onChange, label, className, error }) => (
  <div className={className}>
    <div>
      <p className="font-13 in-grey-200 m-b-10 m-r-15">
        {label}
      </p>

      {error && (
        <div className="main-input__hint in-pink-500 is-visible">{error}</div>
      )}
    </div>

    <Rating
      initialRate={value || 0}
      onChange={onChange}
      full="icon-star in-green-500"
      empty="icon-star in-grey-200"
    />
  </div>
)

StarRating.propTypes = {
  onChange: PropTypes.func.isRequired
}

export default StarRating
