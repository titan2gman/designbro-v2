import React from 'react'
import PropTypes from 'prop-types'
import { Modal } from 'semantic-ui-react'

const WrongFileFormatModalHeader = ({ onClose: handleClose }) => (
  <div className="modal-primary__header bg-pink-500 in-white">
    <div className="modal__actions--top-right hidden-md-up">
      <button
        type="button"
        onClick={handleClose}
        className="modal-close">

        <i className="icon icon-cross in-white" />
      </button>
    </div>

    <p className="modal-primary__header-title">
      Wrong File Format!
    </p>
  </div>
)

WrongFileFormatModalHeader.propTypes = {
  onClose: PropTypes.func.isRequired
}

const WrongFileFormatModalContent = ({ onClose: handleClose }) => (
  <div>
    <div className="modal-primary__body">
      <div className="modal-primary__body-block">
        <p className="modal-primary__text">
          You are trying to upload wrong file format.
          <br />

          Please retry and use only PNG, JPG, PDF, AI, TIFF, EPS, PSD, PSB, PPT, PPTX, DOC, DOCX, SVG, INDD, ICO, XD, MP4.
        </p>
      </div>
    </div>

    <div className="modal-primary__actions flex-end">
      <button id="coming-soon-ok-btn" className="main-button-link main-button-link--lg main-button-link--black-pink m-b-10" type="button" onClick={handleClose}>
        Got, it! <i className="m-l-20 font-8 icon-arrow-right-long" />
      </button>
    </div>
  </div>
)

WrongFileFormatModalContent.propTypes = {
  onClose: PropTypes.func.isRequired
}

const WrongFileFormatModal = ({ onClose: handleClose }) => (
  <Modal id="coming-soon-modal" className="main-modal" size="small" onClose={handleClose} open>
    <div className="modal-primary">
      <WrongFileFormatModalHeader onClose={handleClose} />
      <WrongFileFormatModalContent onClose={handleClose} />
    </div>
  </Modal>
)

export default WrongFileFormatModal
