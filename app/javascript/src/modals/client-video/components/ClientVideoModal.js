import React from 'react'
import PropTypes from 'prop-types'
import { Modal } from 'semantic-ui-react'

const ClientVideoModal = ({ onClose: handleClose }) => (
  <Modal id="client-video-modal" className="main-modal" size="small" onClose={handleClose} open>
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
            src="https://www.youtube.com/embed/-fwDKQXkQHU"
          />
        </div>
      </div>
    </div>
  </Modal>
)

ClientVideoModal.propTypes = {
  onClose: PropTypes.func.isRequired
}

export default ClientVideoModal
