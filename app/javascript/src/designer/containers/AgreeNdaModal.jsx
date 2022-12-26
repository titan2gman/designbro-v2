import React from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import { Modal } from 'semantic-ui-react'

import { hideModal } from '@actions/modal'

const AgreeNdaModal = ({ onClose, onConfirm, value }) => (
  <Modal id="block-designer-modal" className="main-modal main-modal--xs" size="small" open onClose={onClose}>
    <div className="modal-primary">
      <div className="modal-primary__header conv-modal-primary-header">
        <p className="modal-primary__header-title text-center">
          Non-Disclosure Agreement
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
        <button className="main-button-link main-button-link--lg main-button-link--grey-black m-b-10" type="button" onClick={onClose}>
          Cancel
        </button>

        <button id="modal-confirm" className="main-button-link main-button-link--lg main-button-link--black-pink m-b-10" type="button" onClick={() => { onConfirm(); onClose() }}>
          I Agree

          <i className="m-l-20 font-8 icon-arrow-right-long" />
        </button>
      </div>
    </div>
  </Modal>
)

AgreeNdaModal.propTypes = {
  onClose: PropTypes.func.isRequired,
  onConfirm: PropTypes.func.isRequired
}

const mapDispatchToProps = {
  onClose: hideModal
}

export default connect(null, mapDispatchToProps)(AgreeNdaModal)
