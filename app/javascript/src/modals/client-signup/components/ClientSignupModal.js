import React from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import { Modal } from 'semantic-ui-react'

import { hideModal } from '@actions/modal'

import SignupClient from '@components/signup/Client'

const ClientSignupModal = ({ handleClose }) => (
  <Modal
    open
    size="small"
    onClose={handleClose}
    className="main-modal main-modal--xs">

    <SignupClient
      showSaveWorkHint
      asModalWindow
    />
  </Modal>
)

ClientSignupModal.propTypes = {
  handleClose: PropTypes.func.isRequired
}

const mapDispatchToProps = {
  handleClose: hideModal
}

export default connect(null, mapDispatchToProps)(
  ClientSignupModal
)
