import React, { Component } from 'react'
import Slider from 'rc-slider'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import { Control } from 'react-redux-form'

const sliderClassName = (value, neutralValue) => {
  if (value === neutralValue) {
    return 'slider-line--center'
  }

  return value > neutralValue ? 'slider-line--right' : 'slider-line'
}

const leftLabelTextClassName = (value, neutralValue) =>
  classNames(
    'slider-row__text', 'slider-row__text--first',
    'bfs-slider-row__text', 'bfs-slider-row__text-first',
    value < neutralValue ? 'in-black' : 'in-grey-200'
  )

const rightLabelTextClassName = (value, neutralValue) =>
  classNames(
    'bfs-slider-row__text', 'slider-row__text',
    value > neutralValue ? 'in-black' : 'in-grey-200'
  )

const SliderComponent = ({ value, neutralValue, minValue, maxValue, leftLabelText, rightLabelText, onChange, onAfterChange }) => (
  <div className="slider-row">
    <div className="slider-row__cell">
      <Slider
        value={value}
        min={minValue}
        max={maxValue}
        tipFormatter={null}
        onChange={onChange}
        onAfterChange={onAfterChange}
        className={sliderClassName(value, neutralValue)}
      />
    </div>

    <div className={leftLabelTextClassName(value, neutralValue)}>
      {leftLabelText}
    </div>

    <div className={rightLabelTextClassName(value, neutralValue)}>
      {rightLabelText}
    </div>
  </div>
)

SliderComponent.propTypes = {
  onAfterChange: PropTypes.func,
  name: PropTypes.string.isRequired,
  neutralValue: PropTypes.number.isRequired,
  value: PropTypes.number.isRequired,
  leftLabelText: PropTypes.string.isRequired,
  rightLabelText: PropTypes.string.isRequired
}

SliderComponent.defaultProps = {
  minValue: 0,
  maxValue: 10,
  neutralValue: 5
}

export default SliderComponent
