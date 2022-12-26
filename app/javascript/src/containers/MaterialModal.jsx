import pick from 'lodash/pick'
import isFunction from 'lodash/isFunction'

import PropTypes from 'prop-types'
import classNames from 'classnames'
import React, { Component } from 'react'
import { Modal } from 'semantic-ui-react'
import CloseModalButton from '@components/CloseModalButton'

const headerClassNames = (color) => (
  classNames('modal-primary__header conv-modal-primary-header',
    { 'bg-green-500 in-white': color === 'red' })
)

const ModalHeader = ({ title, close, color }) =>
  (<div className={headerClassNames(color)}>
    <span className="modal-primary__header-title text-center">{title}</span>
    <div className="modal__actions--top-right hidden-md-up">
      <button className="modal-close" type="button" onClick={close}>
        <i className="icon icon-cross in-black" />
      </button>
    </div>
  </div>)

const ModalButtons = ({ cancelButton, okButton, onCancelButtonClose, onOkButtonClose }) =>
  (<div className="modal-primary__actions conv-modal-primary-actions conv-confirmation-primary-actions align-items-start">
    <button className="main-button-link main-button-link--lg main-button-link--grey-black m-b-10" type="button" onClick={onCancelButtonClose}>
      {cancelButton}
    </button>
    <button id="modal-confirm" className="main-button-link main-button-link--lg main-button-link--black-pink m-b-10" type="button" onClick={onOkButtonClose}>
      {okButton}
    </button>
  </div>)

const ModalText = ({ value }) =>
  (<div className="modal-primary__body">
    <div className="modal-primary__body-block conv-confirmation-modal-primary-body-block">
      { value }
    </div>
  </div>)

class MaterialModal extends Component {
  state = { open: false }

  close = () => this.setState({ open: false })
  open = () => this.setState({ open: true })

  render () {
    const { size, className, trigger, title, value, cancelButton, okButton, onOkButton, onCancelButton, color, linkClasses, isClosable } = this.props
    const { open, close } = this
    const buttonsExist = cancelButton || okButton
    const buttonProps = pick(this.props, ['cancelButton', 'okButton'])
    const onOkButtonClose = () => {
      if (isFunction(onOkButton)) {
        onOkButton()
      }

      close()
    }
    const onCancelButtonClose = () => {
      if (isFunction(onCancelButton)) {
        onCancelButton()
      }

      close()
    }

    return (
      <Modal
        id="block-designer-modal"
        open={this.state.open}
        onClose={onCancelButtonClose}
        className={classNames('main-modal', className)}
        size={size}
        trigger={
          <span onClick={open} className={linkClasses}>
            {trigger}
          </span>
        }>
        <div className="modal-primary">
          {!!title && <ModalHeader title={title} close={close} color={color} />}
          {isClosable && <CloseModalButton onClose={close} />}
          <ModalText value={value} />
          {buttonsExist &&
            <ModalButtons
              {...buttonProps}
              onOkButtonClose={onOkButtonClose}
              onCancelButtonClose={onCancelButtonClose}
            />
          }
        </div>
      </Modal>
    )
  }
}

const stringOrObjectPropType =
  PropTypes.oneOfType([
    PropTypes.string,
    PropTypes.object
  ])

MaterialModal.propTypes = {
  trigger: stringOrObjectPropType.isRequired,
  value: stringOrObjectPropType.isRequired,
  color: PropTypes.oneOf(['white', 'red']),
  cancelButton: stringOrObjectPropType,
  okButton: stringOrObjectPropType,
  title: stringOrObjectPropType,
  linkClasses: PropTypes.string,
  className: PropTypes.string,

  onCancelButton: PropTypes.func,
  onOkButton: PropTypes.func
}

MaterialModal.defaultProps = {
  size: 'small',
  className: 'main-modal--xs',
  isClosable: false
}

export default MaterialModal
