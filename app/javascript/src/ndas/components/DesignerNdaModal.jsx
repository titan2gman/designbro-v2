import React from 'react'
import PropTypes from 'prop-types'
import { Modal } from 'semantic-ui-react'

const DesignerNdaModal = ({ brand, nda, isOpened, open, close }) => {
  const trigger = (
    <div
      onClick={open}
      className="table-row-item__text-link table-row-item__text text-underline cursor-pointer"
    >
      {brand.name}
    </div>
  )

  return (
    <Modal className="secondary-modal" size="large" open={isOpened} trigger={trigger}>
      <div className="secondary-modal__actions modal__actions--top-right">
        <div className="cursor-pointer modal-close" onClick={close}>
          <i className="icon-cross" />
        </div>
      </div>
      <div className="secondary-modal__content">
        <div className="secondary-modal__header">
          <p className="secondary-modal__title">
            Non-Disclosure Agreement
          </p>

          <p className="secondary-modal__text text-underline">
            {brand.name}
          </p>
        </div>
        <div className="secondary-modal__body">
          <p className="secondary-modal__text">
            {nda.value}
          </p>
        </div>
      </div>
    </Modal>
  )
}

DesignerNdaModal.propTypes = {
  brand: PropTypes.shape({
    name: PropTypes.string.isRequired
  }),

  nda: PropTypes.shape({
    value: PropTypes.string.isRequired
  }),

  isOpened: PropTypes.bool.isRequired,
  close: PropTypes.func.isRequired,
  open: PropTypes.func.isRequired
}

export default DesignerNdaModal
