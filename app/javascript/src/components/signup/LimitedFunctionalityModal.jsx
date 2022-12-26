import React from 'react'
import PropTypes from 'prop-types'
import { Modal } from 'semantic-ui-react'

const SignupLimitedFunctionalityModal = ({ isOpen, onClose, text }) => (
  <Modal className="main-modal" size="small" open={isOpen} closeOnEscape closeOnRootNodeClick onClose={onClose}>
    <div className="main-modal__info">
      <div className="main-modal__info-body">
        <i className="main-modal__info-icon icon-warn-triangle in-green-500" />
        <p className="main-modal__info-text">{text}</p>
      </div>
      <div className="main-modal__actions">
        <button className="main-button-link main-button-link--grey-black main-button-link--lg m-b-10" type="button" onClick={(e) => { e.preventDefault(); onClose() }}>
          Go Back
        </button>
      </div>
    </div>
  </Modal>
)

SignupLimitedFunctionalityModal.propTypes = {
  isOpen: PropTypes.bool.isRequired,
  text: PropTypes.string.isRequired,
  onClose: PropTypes.func.isRequired
}

export default SignupLimitedFunctionalityModal
