import React from 'react'
import cn from 'classnames'
import Slider from 'rc-slider'

import styles from './Slider.module.scss'

const startPoint = 5

const SliderComponent = ({ leftLabel, rightLabel, name, value, marks, onChange, onAfterChange }) => {
  const handleChange = (value) => {
    onChange(name, value)
  }

  return (
    <div className={styles.sliderWrapper}>
      <Slider
        className={styles.slider}
        dots
        value={value}
        startPoint={startPoint}
        min={startPoint - 3}
        max={startPoint + 3}
        onChange={handleChange}
        onAfterChange={onAfterChange}
        marks={marks}
        handleStyle={{
          width: '12px',
          height: '12px',
          marginTop: '-6px',
          border: 'none',
          background: '#18da8e',
          boxShadow: 'none',
        }}
        dotStyle={{
          marginLeft: '-6px',
          width: '12px',
          height: '12px',
          border: 'none',
          background: '#e0e4e7',
        }}
        activeDotStyle={{
          background: '#18da8e'
        }}
        railStyle={{
          height: '12px',
          marginTop: '-6px',
          borderRadius: 0,
          background: '#eff1f3'
        }}
        trackStyle={{
          height: '12px',
          marginTop: '-6px',
          background: '#18da8e',
          borderRadius: 0
        }}
      />

      <div
        className={cn(styles.leftLabel, { [styles.active]: value < startPoint })}
      >{leftLabel}
      </div>

      <div
        className={cn(styles.rightLabel, { [styles.active]: value > startPoint })}
      >{rightLabel}
      </div>
    </div>
  )
}


export default SliderComponent
