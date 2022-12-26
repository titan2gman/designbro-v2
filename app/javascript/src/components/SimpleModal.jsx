import React from 'react'
import { Modal } from 'semantic-ui-react'
import classNames from 'classnames'

const SimpleModal = ({ title, message, open, onClose, className }) => (
  <Modal id="simple-modal" className={classNames('main-modal', className)} size="small" onClose={onClose} open={open}>
    <div className="modal-primary">
      <div className="modal-primary__header bg-green-500 in-white">
        <div className="modal__actions--top-right hidden-md-up">
          <button className="modal-close" type="button" onClick={onClose}>
            <i className="icon icon-cross in-white" />
          </button>
        </div>
        <p className="modal-primary__header-title">{title}</p>
      </div>
      <div className="modal-primary__body">
        <div className="modal-primary__body-block">
          <p className="modal-primary__text">{message}</p>
        </div>
      </div>
      <div className="modal-primary__actions flex-end">
        <button id="simple-modal-close" className="main-button-link main-button-link--lg main-button-link--black-pink m-b-10" type="button" onClick={onClose}>
          OK
          <i className="m-l-20 font-8 icon-arrow-right-long" />
        </button>
      </div>
    </div>
  </Modal>
)

export default SimpleModal
