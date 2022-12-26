import React from 'react'
import PropTypes from 'prop-types'

import ExamplesRow from './ExamplesRow'

const BadExamples = ({ images }) =>
  (<div className="bfs-content__flex-item bfs-example__block--first">
    <p className="font-bold m-b-10">
      Bad examples <span className="font-11 in-grey-200">(optional)</span>
    </p>

    <ExamplesRow images={images.slice(0, 3)} />
    <ExamplesRow images={images.slice(3, 6)} />
  </div>)

BadExamples.propTypes = {
  images: PropTypes.arrayOf(
    PropTypes.object
  ).isRequired
}

export default BadExamples
