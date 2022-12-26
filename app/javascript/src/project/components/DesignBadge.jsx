import React from 'react'
import PropTypes from 'prop-types'

const Badge = ({ text }) => (
  <span className="status-indicator in-white" style={{ backgroundColor: '#4b4d4f' }}>{text}</span>
)

Badge.propTypes = {
  text: PropTypes.string.isRequired
}

export default Badge
