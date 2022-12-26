import React, { useState } from 'react'
import _ from 'lodash'
import PropTypes from 'prop-types'
import { ChromePicker } from 'react-color'
import cn from 'classnames'
import Button from '../Button'

import styles from './ColorPicker.module.scss'

const Thumbnail = ({ color, onSelect, onDestroy }) => {
  const handleSelect = () => {
    onSelect(color)
  }

  const handleDestroy = (event) => {
    event.stopPropagation()
    onDestroy(color)
  }

  return (
    <div
      className={styles.thumbnail}
      style={{ background: color }}
      onClick={handleSelect}
    >
      <div className={cn('icon-cross', styles.deleteDesign)} onClick={handleDestroy} />
    </div>
  )
}

Thumbnail.propTypes = {
  color: PropTypes.string,
  onSelect: PropTypes.func,
  onDestroy: PropTypes.func
}

const ActiveColor = ({
  color,
  onChange
}) => {
  const [colorState, setColorState] = useState(color)

  const handleSelectButtonClick = (e) => {
    e.preventDefault()

    onChange(colorState)

    setColorState(undefined)
  }

  const handlePickerChange = (color) => {
    setColorState(color.hex)
  }

  const handleSelectColorClick = () => {
    setColorState('#fff')
  }

  return colorState ? (
    <div className={styles.colorPicker}>
      <ChromePicker
        styles={{
          default: {
            picker: {
              width: '100%',
              boxShadow: 'none',
              boxSizing: 'border-box',
              borderRadius: 'none'
            },
            saturation: {
              paddingBottom: '30%'
            }
          }
        }}
        disableAlpha
        color={colorState}
        onChangeComplete={handlePickerChange}
      />

      <Button
        className={styles.selectButton}
        onClick={handleSelectButtonClick}
      >
        Select
      </Button>
    </div>
  ) : (
    <div className={styles.selectColor} onClick={handleSelectColorClick}>
      <div className={styles.selectColorIcon} />
      <div className={styles.selectColorText}>
        Select color
      </div>
    </div>
  )
}

ActiveColor.propTypes = {
  color: PropTypes.string,
  onChange: PropTypes.func
}

const ColorPicker = ({
  colors,
  children,
  onChange,
}) => {
  const [activeColor, setActiveColor] = useState(null)

  const thumbnails = activeColor ? colors.filter((color) => color !== activeColor) : colors

  const handleThumbnailDestroy = (color) => {
    const nextColors = colors.filter((c) => c !== color)

    onChange(nextColors)
  }

  const handleSelect = (color) => {
    setActiveColor(color)
  }

  const handleChange = (color) => {
    const nextColors = _.uniq([...colors.filter(c => c !== activeColor), color])

    setActiveColor(null)

    onChange(nextColors)
  }

  return (
    <div className={styles.imageUploaderWrapper}>
      <div className={styles.previewWrapper}>
        <ActiveColor
          color={activeColor}
          onChange={handleChange}
        />

        {children}
      </div>

      <div className={styles.thumbnailsWrapper}>
        <div className={styles.thumbnailsInnerWrapper}>
          {thumbnails.map((color) => (
            <Thumbnail
              key={color}
              color={color}
              onSelect={handleSelect}
              onDestroy={handleThumbnailDestroy}
            />
          ))}
        </div>
      </div>

      <div className={styles.rightPanel} />
    </div>
  )
}

ColorPicker.propTypes = {
  colors: PropTypes.arrayOf(PropTypes.object),
  activeColor: PropTypes.object,
  setActiveColor: PropTypes.func,
  onChange: PropTypes.func
}

export default ColorPicker
