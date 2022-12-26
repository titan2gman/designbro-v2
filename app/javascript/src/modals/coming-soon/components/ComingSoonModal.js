import React from 'react'
import { Form } from 'react-redux-form'
import { Modal } from 'semantic-ui-react'

import { required } from '@utils/validators'

import MaterialInput from '@components/inputs/MaterialInput'

const RequestForm = ({ onClose, onSubmit }) => (
  <Form model="forms.comingSoon" onSubmit={onSubmit}>
    <div className="modal-primary__header bg-green-500 in-white">
      <div className="modal__actions--top-right hidden-md-up">
        <button className="modal-close" type="button" onClick={onClose}>
          <i className="icon icon-cross in-white" />
        </button>
      </div>
      <p className="modal-primary__header-title">Sorry... We're not fully up &amp; running yet.</p>
    </div>

    <div className="modal-primary__body">
      <div className="modal-primary__body-block">
        <p className="modal-primary__subtitle">But we will be very shortly!</p>
        <p className="modal-primary__subtitle">Please leave us your details below, and we will drop you an email as soon as we're ready.</p>
        <MaterialInput
          model=".email"
          label="Email"
          id="email"
          type="email"
          name="email"
          validators={{ required }}
          errors={{ required: 'Please enter your email' }}
        />
      </div>
    </div>

    <div className="modal-primary__actions flex-end">
      <button className="main-button-link main-button-link--lg main-button-link--black-pink m-b-10" type="Submit" id="notify-me-submit">
        Notify Me
        <i className="m-l-20 font-8 icon-arrow-right-long" />
      </button>
    </div>
  </Form>
)

const Thanks = ({ onClose }) => (
  <div>
    <div className="modal-primary__header bg-green-500 in-white">
      <div className="modal__actions--top-right hidden-md-up">
        <button className="modal-close" type="button" onClick={onClose}>
          <i className="icon icon-cross in-white" />
        </button>
      </div>
      <p className="modal-primary__header-title">Thank you!</p>
    </div>

    <div className="modal-primary__body">
      <div className="modal-primary__body-block">
        <p className="modal-primary__subtitle">You will be informed when we are fully up and running.</p>
      </div>
    </div>

    <div className="modal-primary__actions flex-end">
      <button id="coming-soon-ok-btn" className="main-button-link main-button-link--lg main-button-link--black-pink m-b-10" type="button" onClick={onClose}>
        OK <i className="m-l-20 font-8 icon-arrow-right-long" />
      </button>
    </div>
  </div>
)

const ComingSoonModal = ({ saved, onClose, onSubmit }) => (
  <Modal id="coming-soon-modal" className="main-modal" size="small" onClose={onClose} open>
    <div className="modal-primary">
      {saved ? <Thanks onClose={onClose} /> : <RequestForm onClose={onClose} onSubmit={onSubmit} />}
    </div>
  </Modal>
)

export default ComingSoonModal
