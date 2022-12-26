import React from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

import { REQUIRED_GOOD_EXAMPLES_COUNT } from '@constants'

import ExamplesRow from './ExamplesRow'

const Notification = ({ imagesCount, isEnough }) => (
  <p className={classNames('bfs-example__block-hint', { 'in-green-300': isEnough, 'in-grey-200': !isEnough })}>
    {isEnough ? `You have already selected ${REQUIRED_GOOD_EXAMPLES_COUNT} good examples! Press continue to proceed` : `Please select ${REQUIRED_GOOD_EXAMPLES_COUNT - imagesCount} more good examples to continue to the next step`}
  </p>
)

Notification.propTypes = {
  isEnough: PropTypes.bool.isRequired
}

const GoodExamples = ({ images, isEnough }) => (
  <div className="bfs-content__flex-item bfs-example__block--last bfs-content__flex-item--order2">
    <p className="font-bold m-b-5">Good examples</p>

    <ExamplesRow images={images.slice(0, 3)} />
    <ExamplesRow images={images.slice(3, 6)} />

    <Notification isEnough={isEnough} imagesCount={images.length} />
  </div>
)

GoodExamples.propTypes = {
  images: PropTypes.arrayOf(
    PropTypes.object
  ).isRequired,

  isEnough: PropTypes.bool.isRequired
}

export default GoodExamples
