import React from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import { Modal } from 'semantic-ui-react'

import { hideModal } from '@actions/modal'

const SuccessModal = ({ onClose, value }) => (
  <Modal id="block-designer-modal" className="main-modal main-modal--xs" size="small" open onClose={onClose}>
    <div className="modal-primary">
      <div className="modal-primary__header conv-modal-primary-header bg-green-500 in-white">
        <p className="modal-primary__header-title">
          Success
        </p>
      </div>

      <div className="modal-primary__body">
        <div className="modal-primary__body-block conv-confirmation-modal-primary-body-block">
          <p className="in-grey-200 font-14 pre-wrap">
            {value}
          </p>
        </div>
      </div>

      <div className="modal-primary__actions conv-modal-primary-actions conv-confirmation-primary-actions align-items-start">
        <button id="modal-confirm" className="main-button-link main-button-link--lg main-button-link--black-pink m-b-10" type="button" onClick={onClose}>
          Ok

          <i className="m-l-20 font-8 icon-arrow-right-long" />
        </button>
      </div>
    </div>
  </Modal>
)

SuccessModal.propTypes = {
  onClose: PropTypes.func.isRequired,
  value: PropTypes.string.isRequired
}

const mapDispatchToProps = (dispatch, ownProps) => ({
  onClose: () => {
    ownProps.onConfirm()
    hideModal()
  }
})

export default connect(null, mapDispatchToProps)(SuccessModal)
