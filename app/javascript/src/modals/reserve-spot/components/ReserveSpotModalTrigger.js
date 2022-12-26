import React from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

const ReserveSpotModalTrigger = ({ containerClassName, textClassName, showReserveSpotModal }) => (
  <div className={classNames('in-black cursor-pointer', containerClassName)}
    onClick={showReserveSpotModal}
    id="reserve-spot">

    <span className={textClassName}>
      Reserve Spot
    </span>

    <i className="icon-arrow-right-circle m-l-10 align-middle font-40" />
  </div>
)

ReserveSpotModalTrigger.propTypes = {
  textClassName: PropTypes.string,
  containerClassName: PropTypes.string,

  showReserveSpotModal: PropTypes.func.isRequired
}

export default ReserveSpotModalTrigger
