import React from 'react'
import PropTypes from 'prop-types'
import { Modal } from 'semantic-ui-react'

const DesignerVideoModal = ({ onClose: handleClose }) => (
  <Modal id="designer-video-modal" className="main-modal" size="small" onClose={handleClose} open>
    <div className="modal-video">
      <div className="modal-primary">
        <div className="modal-video__header">
          <p className="m-b-0" />

          <button className="modal-close" type="button" onClick={handleClose}>
            <i className="icon-cross" />
          </button>
        </div>

        <div className="modal-video__body">
          <iframe
            frameBorder="0"
            allowFullScreen
            className="modal-video__content"
            src="https://www.youtube.com/embed/d-qaRX9Y0gQ"
          />
        </div>
      </div>
    </div>
  </Modal>
)

DesignerVideoModal.propTypes = {
  onClose: PropTypes.func.isRequired
}

export default DesignerVideoModal
