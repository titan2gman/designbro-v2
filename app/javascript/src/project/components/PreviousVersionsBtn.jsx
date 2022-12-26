import React from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

const PreviousVersionsBtn = ({ disabled, onClick, className }) => (
  <button id="restore-previous-versions-btn" disabled={disabled} onClick={disabled ? () => {} : onClick} className={classNames('conv-actions__btn-darkgrey-negative', className)}>
    <i className="icon-time-ago-circle conv-actions__icon"/>
    Previous designs
  </button>
)

PreviousVersionsBtn.propTypes = {
  disabled: PropTypes.bool,
  onClick: PropTypes.func.isRequired,
  classNames: PropTypes.string
}

export default PreviousVersionsBtn
