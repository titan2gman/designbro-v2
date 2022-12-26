import React from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import { Modal } from 'semantic-ui-react'

import { hideModal } from '@actions/modal'

import TermsModal from '@components/modals/TermsModal'

const ApproveFilesModal = ({ onClose, onConfirm }) => (
  <Modal onClose={onClose} open className="main-modal small" id="approve-files-modal">
    <div className="main-modal__info">
      <div className="main-modal__info-body">
        <i className="main-modal__info-icon icon-check-outside-circle in-green-500" />
        <span className="main-modal__info-text">
          I approve the files and agree to the DesignBro <TermsModal linkClasses="text-underline in-black cursor-pointer" trigger="Terms & Conditions" />
        </span>
      </div>
      <div className="main-modal__actions">
        <button onClick={onClose} className="main-button-link main-button-link--grey-black main-button-link--lg m-b-10" type="button">
          Cancel
        </button>

        <button onClick={onConfirm} id="confirm-and-continue" type="button"
          className="main-button-link main-button-link--black-pink main-button-link--lg m-b-10">

          Confirm and continue

          <i className="m-l-20 font-8 icon-arrow-right-long" />
        </button>
      </div>
    </div>
  </Modal>
)

ApproveFilesModal.propTypes = {
  onClose: PropTypes.func.isRequired,
  onConfirm: PropTypes.func.isRequired
}

const mapDispatchToProps = {
  onClose: hideModal
}

export default connect(null, mapDispatchToProps)(ApproveFilesModal)
