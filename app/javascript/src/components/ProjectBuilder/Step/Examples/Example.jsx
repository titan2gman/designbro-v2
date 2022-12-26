import React from 'react'
import PropTypes from 'prop-types'

const styleForImage = (image) => ({
  backgroundImage: `url(${image.url})`
})

const Example = ({ openStep, image, markExampleAsCancelled }) => (
  <div className="col-xs-4">
    <div className="bfs-example__img" style={styleForImage(image)}>
      <div className="bfs-example__remove" onClick={() => markExampleAsCancelled(image.id, openStep)}>
        <i className=" icon-cross in-white font-13 m-auto" />
      </div>
    </div>
  </div>
)

const imageShape = PropTypes.shape({
  url: PropTypes.string.isRequired
})

Example.propTypes = {
  markExampleAsCancelled: PropTypes.func.isRequired,
  image: imageShape.isRequired
}

export default Example
