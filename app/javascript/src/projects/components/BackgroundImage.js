import React from 'react'
import PropTypes from 'prop-types'
import { Link } from 'react-router-dom'

const ImageFrame = ({ designImage }) => (
  <div
    style={{ backgroundImage: `url('${designImage}')` }}
    className="preview-frame preview-frame__img bg-grey-100 cursor-pointer"
  />
)

ImageFrame.propTypes = {
  designImage: PropTypes.string.isRequired
}

const BackgroundImage = ({ asLink, design, onClick }) => (
  <div>
    {asLink ?
      <div onClick={onClick}>
        <ImageFrame designImage={design.image} />
      </div>
      :
      <ImageFrame designImage={design.image} />
    }
  </div>
)

BackgroundImage.propTypes = {
  asLink: PropTypes.bool.isRequired,
  design: PropTypes.shape({
    id: PropTypes.string.isRequired,
    image: PropTypes.string.isRequired,
    project: PropTypes.string.isRequired
  })
}

export default BackgroundImage
