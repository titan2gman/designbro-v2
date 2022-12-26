import React, { Component } from 'react'
import { Modal } from 'semantic-ui-react'
import BrandsList from './BrandsListContainer'
import BrandNameForm from './BrandNameFormContainer'

const ModalHeader = ({ children }) => (
  <div className="modal-primary__header conv-modal-primary-header">
    <span className="modal-primary__header-title text-center">{children}</span>
  </div>
)

const ModalBody = ({ children }) => (
  <div className="modal-primary__body">
    <div className="modal-primary__body-block conv-confirmation-modal-primary-body-block">
      {children}
    </div>
  </div>
)

const ModalFooter = ({ children }) => (
  <div className="modal-primary__actions conv-modal-primary-actions conv-confirmation-primary-actions align-items-start">
    <span/>
    { children }
  </div>
)

const BrandsModal = ({ onContinue }) => {
  return (
    <Modal
      className="main-modal main-modal--sm"
      size="not-small"
      open
      closeOnDimmerClick={false}
    >
      <div className="modal-primary">
        <ModalHeader>
          Select the brand for your next project
        </ModalHeader>

        <ModalBody>
          <BrandsList />
          <BrandNameForm />
        </ModalBody>

        <ModalFooter>
          <button className="main-button-link main-button-link--lg main-button-link--black-pink m-b-10" type="button" onClick={onContinue}>
            Continue
          </button>
        </ModalFooter>
      </div>
    </Modal>
  )
}

export default BrandsModal
