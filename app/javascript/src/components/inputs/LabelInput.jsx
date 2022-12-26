import React from 'react'
import PropTypes from 'prop-types'

const LabelInput = ({ label, children }) => (
  <div className="row">
    <div className="col-xs-12 col-lg-6">
      <span className="join-profile-info__form-label">{label}</span>
    </div>
    <div className="col-xs-8 col-lg-6">
      {children}
    </div>
  </div>
)

LabelInput.propTypes = {
  label: PropTypes.string.isRequired,
  children: PropTypes.node.isRequired
}

export default LabelInput
