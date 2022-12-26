import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import Zoom from 'react-img-zoom'

import Spinner from '@components/Spinner'

const DesignCurrentWork = ({ loading, imageUrl, isFullscreen, isBadgePresent }) => {
  const [width, setWidth] = useState(0)
  const [height, setHeight] = useState(0)
  let naturalWidth = 0
  let naturalHeight = 0

  const calSize = () => {
    let _width = 0
    let _height = 0
    let ratio = {}

    const convDesignContent = document.getElementsByClassName('conv-design__content')[0]
    if (convDesignContent) {
      const padding = parseInt(getComputedStyle(convDesignContent)['padding'] || getComputedStyle(convDesignContent)['-moz-padding-end'])
      const widthMax = convDesignContent.clientWidth - padding * 2
      const heightMax = isBadgePresent ? convDesignContent.clientHeight - padding * 2 - 28 : convDesignContent.clientHeight - padding * 2

      ratio = {
        w: widthMax / naturalWidth,
        h: heightMax / naturalHeight
      }

      if (ratio.w > ratio.h) {
        _height = heightMax
        _width = naturalWidth * ratio.h
      } else {
        _width = widthMax
        _height = naturalHeight * ratio.w
      }
    }
    setWidth(_width)
    setHeight(_height)
  }

  const handleWindowResize = (e) => {
    calSize()
  }

  useEffect(() => {
    window.addEventListener('resize', handleWindowResize)

    return () => {
      window.removeEventListener('resize', handleWindowResize)
    }
  }, [])

  useEffect(() => {
    const img = new Image()
    img.src = imageUrl
    img.onload = function() {
      naturalWidth = img.naturalWidth
      naturalHeight = img.naturalHeight
      calSize()
    }
  }, [loading, imageUrl, isBadgePresent])

  return (
    <Spinner loading={loading} key={`${imageUrl}-${width}-${height}`} text="Uploading">
      {() => (
        <Zoom
          img={imageUrl}
          zoomScale={3}
          width={width}
          height={height}
          style={{ cursor: 'pointer' }}
        />
      )}
    </Spinner>
  )}

DesignCurrentWork.propTypes = {
  loading: PropTypes.bool.isRequired,
  imageUrl: PropTypes.string.isRequired,
  isFullscreen: PropTypes.bool.isRequired
}

export default DesignCurrentWork
