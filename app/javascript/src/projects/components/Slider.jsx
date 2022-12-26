import React from 'react'
import classNames from 'classnames'

const getSliderStyle = (value) => {
  if (value > 5) {
    return 'slider-row__value--right'
  } else if (value === 5) {
    return 'slider-row__value--center'
  } else {
    return ''
  }
}

const getSliderValue = (value) => {
  if (value > 5) {
    return (10 - value)
  } else {
    return value
  }
}

const Slider = ({ from, to, value }) => (
  <div className="slider-row">
    <div className="slider-row__cell">
      <div className="slider-row__line">
        <div className={classNames('slider-row__value', getSliderStyle(value))} style={{ width: `${getSliderValue(value) * 10}%` }} />
      </div>
    </div>
    <div className="brief-slider__text">
      <span>{from}</span>
    </div>
    <div className="brief-slider__text">
      <span>{to}</span>
    </div>
  </div>
)

export default Slider
