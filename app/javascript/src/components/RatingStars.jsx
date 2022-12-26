import times from 'lodash/times'
import partial from 'lodash/partial'

import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

const RatingStar = ({ onClick, onMouseOver, onMouseOut, className, isClickable }) => (
  <i className={classNames(className, 'icon-star', { 'pointer-events-none': !isClickable })}
    onClick={onClick}
    onMouseOver={onMouseOver} onMouseOut={onMouseOut} />
)

const RatingStars = ({ value, onClick }) => {
  const [currentRating, setCurrentRating] = useState(
    {
      rating: value || null,
      tempRating: null
    }
  )

  const starOver = (rating) => {
    setCurrentRating({
      rating: rating,
      tempRating: currentRating.rating
    })
  }

  const starOut = () => {
    setCurrentRating( (prevState) => (
      { ...prevState, rating: currentRating.tempRating })
    )
  }

  useEffect(() => {
    setCurrentRating({
      rating: value,
      tempRating: value
    })
  }, [value])

  const stars = times(5, (i) =>
    (<RatingStar key={i + 1}
      className={(currentRating.rating > i) ? 'star-green' : 'star-grey' }
      onClick={onClick && partial(onClick, i + 1)}
      onMouseOver={partial(starOver, i)}
      onMouseOut={partial(starOut, i)}
      isClickable={!!onClick}
    />))

  return (
    <>
      {stars}
    </>
  )
}

RatingStars.propTypes = {
  value: PropTypes.number.isRequired
}

export default RatingStars
