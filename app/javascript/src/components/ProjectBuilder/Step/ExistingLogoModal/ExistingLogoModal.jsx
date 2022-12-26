import React from 'react'
import PropTypes from 'prop-types'
import { Modal } from 'semantic-ui-react'
import { Link } from 'react-router-dom'

const LogoModal = ({ onClose }) => {
  return (
    <Modal
      open
      size="small"
      onClose={onClose}
      className="main-modal main-modal--xs"
    >
      <div className="logo-suggestion-modal">
        <p>We suggest to make a logo for you first, you can come back here after</p>

        <p><Link onClick={onClose} to="/projects/new/logo" className="start-logo-project">Start Logo Project</Link></p>

        <p><button className="back" onClick={onClose}>Or go back to your briefing</button></p>
      </div>
    </Modal>
  )
}

export default LogoModal
