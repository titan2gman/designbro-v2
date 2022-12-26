import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { withRouter } from 'react-router-dom'
import { Modal } from 'semantic-ui-react'

class DesignerShareConfirmModal extends Component {
  handleConfirm = () => {
    const { history, submit, hideModal } = this.props

    const callback = () => {
      hideModal()
      history.push('/d/signup/finish')
    }

    submit(callback)
  }

  render () {
    return (
      <Modal className="main-modal" size="small" open onClose={this.props.hideModal}>
        <div className="main-modal__info">
          <div className="main-modal__info-body">
            <i className="main-modal__info-icon icon-check-circle in-green-500" />

            <p className="main-modal__info-text">
              Please confirm that the work you have uploaded is your work
              and that there is nothing prohibiting you from sharing it.
            </p>
          </div>

          <div className="main-modal__actions">
            <div className="main-button-link main-button-link--grey-black main-button-link--lg m-b-10 m-r-15" onClick={this.props.hideModal}>
              Go Back
            </div>

            <div
              id="share-modal-submit"
              className="main-button-link main-button-link--black-pink main-button-link--lg m-b-10"
              onClick={this.handleConfirm}
            >
              Confirm and continue

              <i className="m-l-20 font-8 icon-arrow-right-long" />
            </div>
          </div>
        </div>
      </Modal>
    )
  }
}

DesignerShareConfirmModal.propTypes = {
  createPortfolio: PropTypes.func.isRequired,
  hideModal: PropTypes.func.isRequired
}

export default withRouter(DesignerShareConfirmModal)
