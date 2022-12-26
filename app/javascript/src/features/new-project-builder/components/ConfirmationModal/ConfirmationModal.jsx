import React from 'react'
import cn from 'classnames'
import { Modal } from 'semantic-ui-react'

import Headline from '../Headline'
import Button from '../Button'

import styles from './ConfirmationModal.module.scss'

const ConfirmationModal = ({ onSkip, onClose }) => {
  return (
    <Modal
      size="tiny"
      open
      className={styles.modal}
    >
      <div className={cn('icon-cross', styles.closeIcon)} onClick={onClose} />

      <Modal.Content className={styles.modalContent}>
        <Headline className={styles.heading}>Are you sure you want to skip?</Headline>
        <p className={styles.subheading}>This would really help the designers and would likely give better results for your project.</p>


        <div className={styles.modalFooter}>
          <Button onClick={onSkip}>Yes, skip →</Button>

          <p>
            <span className={styles.createNewAccount} onClick={onClose}>No, go back</span>
          </p>
        </div>
      </Modal.Content>
    </Modal>
  )
}

export default ConfirmationModal
