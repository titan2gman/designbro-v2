import React from 'react'
import classNames from 'classnames'

import { Modal } from 'semantic-ui-react'
import MaterialTextarea from '../inputs/MaterialTextarea'

const ClientModalReview = ({ className }) => (
  <Modal className={classNames('main-modal main-modal--xs', className)} size="small" trigger={
    <a className="text-underline in-white" href="#">leave a review</a>
  }>
    <div className="modal-primary">
      <div className="modal-primary__body">
        <div className="modal-primary__body-block conv-review-modal-primary-body-block text-center">
          <div className="main-userpic main-userpic-lg m-b-20">
            <span className="main-userpic__text-lg text-truncate text-uppercase">
              td
            </span>
          </div>
          <p className="in-green-500 font-24 font-weight-bold m-b-30">
            Teresa Dean
          </p>
          <p className="in-grey-400 font-13 m-b-25">
            How was your work with the Designer?
          </p>
          <div className="rating-stars conv-review-modal-rating m-b-20">
            <i className="icon-star in-grey-200" />
            <i className="icon-star in-grey-200" />
            <i className="icon-star in-grey-200" />
            <i className="icon-star in-grey-200" />
            <i className="icon-star in-grey-200" />
          </div>
          <div className="conv-review-modal-main-textarea">
            <MaterialTextarea model="forms.stubs.bbb" label="Describe your experinece working with Teresa Dean" id="message" type="text" name="message" autoComplete="message" />
          </div>
        </div>
      </div>
      <div className="modal-primary__actions conv-modal-primary-actions  conv-review-primary-actions">
        <button className="main-button-link main-button-link--lg main-button-link--grey-black m-b-10" type="button">
          Cancel
        </button>
        <button className="main-button-link main-button-link--lg main-button-link--black-pink m-b-10" type="button">
          Confirm and continue
          <i className="m-l-20 font-8 icon-arrow-right-long" />
        </button>
      </div>
    </div>
  </Modal>
)

const ConversationAsideContentMessages = () => (
  <div className="conv-content-aside__body">
    <div className="conv-dialog-item">
      <div className="main-userpic main-userpic-md conv-dialog-item__initials">
        <span className="main-userpic__text-md text-truncate text-uppercase">
          New wefe
        </span>
      </div>
      <div className="conv-dialog-item__header clearfix in-grey-200">
        <span className="conv-dialog-item__header-publish-day">
          1 day
        </span>
        <span className="conv-dialog-item__header-user-name">
          Designer
        </span>
      </div>
      <p className="conv-dialog-item__body m-b-0">
        When WordPress users integrate UI design colors, the results appear on the backend as well as the admin user panel.
      </p>
    </div>
    <p className="conv-notification bg-green-500 in-white">
      Please, <ClientModalReview /> for the designer
    </p>
    <div className="m-b-25 p-t-40">
      <p className="conv-notification-conclusion-title in-grey-200 font-13">
        Winner Selected
      </p>
      <div className="divider-line" />
    </div>
    <div className="conv-dialog-item">
      <div className="main-userpic main-userpic-md conv-dialog-item__initials">
        <span className="main-userpic__text-md text-truncate text-uppercase">
          New wefe
        </span>
      </div>
      <div className="conv-dialog-item__header clearfix in-grey-200">
        <span className="conv-dialog-item__header-publish-day">
          1 day
        </span>
        <span className="conv-dialog-item__header-user-name">
          Designer
        </span>
      </div>
      <p className="conv-dialog-item__body m-b-0">
        When WordPress users integrate UI design colors, the results appear on the backend as well as the admin user panel.
      </p>
    </div>
    <p className="conv-notification bg-green-300 in-white">
      Winner is selected! Client is waiting for <a className="text-underline in-white" href="#">files sources</a>.
    </p>
    <div className="m-b-25 p-t-40">
      <p className="conv-notification-conclusion-title in-grey-200 font-13">
        Winner Selected
      </p>
      <div className="divider-line" />
    </div>
  </div>
)

export default ConversationAsideContentMessages
