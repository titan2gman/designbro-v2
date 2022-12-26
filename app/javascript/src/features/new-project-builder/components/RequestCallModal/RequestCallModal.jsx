import React, { useState } from 'react'
import cn from 'classnames'
import { Modal } from 'semantic-ui-react'

import Headline from '../Headline'
import Button from '../Button'

import styles from './RequestCallModal.module.scss'

const RequestCallModal = ({ trigger }) => {
  const [open, setOpen] = useState(false)

  const handleOpen = () => setOpen(true)
  const handleClose = () => setOpen(false)
  const handleBook = () => {
    window.location.href = 'https://calendly.com/gency-15-minutes/15min'
  }

  return (
    <Modal
      size="tiny"
      onClose={handleClose}
      onOpen={handleOpen}
      open={open}
      className={styles.modal}
      trigger={trigger}
    >
      <div className={cn('icon-cross', styles.closeIcon)} onClick={handleClose} />

      <Modal.Content className={styles.modalContent}>
        <Headline className={styles.headline}>Book your call with one of our experts</Headline>

        <div className={styles.modalFooter}>
          <Button onClick={handleBook}>Book now →</Button>
        </div>
      </Modal.Content>
    </Modal>
  )
}

export default RequestCallModal
