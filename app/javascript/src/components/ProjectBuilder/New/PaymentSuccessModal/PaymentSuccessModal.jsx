import React from 'react'
import classNames from 'classnames'
import { Modal } from 'semantic-ui-react'
import styles from './PaymentSuccessModal.module.scss'
import Button from '@components/Button'

const PaymentSuccessModal = ({ onClose, className }) => {

  return (
    <Modal
      onClose={onClose}
      open
      className={classNames('main-modal main-modal--xs', className)}
      size="small"
    >
      <div className={styles.modalBody}>
        <h2>Payment successful!</h2>
        <Button variant="transparent">
          Continue
        </Button>
      </div>
    </Modal>
  )
}

export default PaymentSuccessModal
