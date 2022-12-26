import React from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import { Modal } from 'semantic-ui-react'

import { hideModal } from '@actions/modal'

import Login from '@login/components/Login'

const ClientLoginModal = ({ handleClose }) => (
  <Modal
    open
    size="small"
    onClose={handleClose}
    className="main-modal main-modal--xs"
  >
    <Login
      showSaveWorkHint
      asModalWindow
    />
  </Modal>
)

ClientLoginModal.propTypes = {
  handleClose: PropTypes.func.isRequired
}

const mapDispatchToProps = {
  handleClose: hideModal
}

export default connect(null, mapDispatchToProps)(
  ClientLoginModal
)
