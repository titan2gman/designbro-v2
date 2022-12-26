import React, { Component } from 'react'
import classNames from 'classnames'
import { Modal } from 'semantic-ui-react'

import DesignerPayoutForm from '@designer/containers/DesignerPayoutForm'

export default class DesignerRequestPaymentModal extends Component {
  state = { open: false }

  close = () => this.setState({ open: false })
  open = () => this.setState({ open: true })

  render () {
    const { payoutMinAmount, className, me } = this.props
    const { open } = this.state

    return (
      <Modal
        open={open}
        onClose={this.close}
        className={classNames('main-modal', className)}
        size="small"
        trigger={
          <div onClick={this.open} className="earn-subheader__info-btn in-black cursor-pointer" id="request-payout">
            Request Payout

            <i className="icon-arrow-right-circle m-l-10 align-middle font-40" />
          </div>
        }>
        <div className="modal-primary">
          <div className="modal-primary__header text-center bg-green-500 in-white">
            <p className="modal-primary__header-title">Request Payout</p>
            <p className="modal-primary__header-text">
              You need to reach a minimum of {payoutMinAmount.amount}$ to be able to request a payout.
            </p>
            <div className="modal__actions--top-right hidden-md-up">
              <button
                className="modal-close"
                type="button"
                onClick={this.close}
              >
                <i className="icon icon-cross in-white" />
              </button>
            </div>

            {me.availableForPayout <= payoutMinAmount.amount && <div className="main-modal__actions flex-end">
              <a className={classNames(
                'in-white',
                'cursor-pointer',
                'main-button-link',
                'main-button-link--lg'
              )} type="button" onClick={this.close}>
                Cancel
              </a>
            </div>}

          </div>

          {me.availableForPayout >= payoutMinAmount.amount && <DesignerPayoutForm
            onClose={this.close}
          />}
        </div>
      </Modal>
    )
  }
}
