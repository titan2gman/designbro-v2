import times from 'lodash/times'

import React from 'react'
import PropTypes from 'prop-types'

import Example from './ExampleContainer'
import EmptyExample from './EmptyExample'

const prepareImages = (images) => times(3, (index) => images[index])

const ExamplesRow = ({ images }) => (
  <div className="row m-b-20">
    {prepareImages(images).map((image, index) => image
      ? <Example key={index} image={image} />
      : <EmptyExample key={index} />
    )}
  </div>
)

ExamplesRow.propTypes = {
  images: PropTypes.arrayOf(
    PropTypes.object
  ).isRequired
}

export default ExamplesRow
