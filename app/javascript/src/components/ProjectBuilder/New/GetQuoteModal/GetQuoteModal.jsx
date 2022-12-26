import React, { useState } from 'react'
import classNames from 'classnames'
import { Modal } from 'semantic-ui-react'
import styles from './GetQuoteModal.module.scss'
import Button from '@components/Button'
import Textarea from 'react-textarea-autosize'

const GetQuoteModal = ({ requestManualProject, showSuccessMessageModal, onClose, className }) => {
  const [content, changeContent] = useState('')
  const [inProgress, changeInProgress] = useState(false)

  const onSubmit = () => {
    changeInProgress(true)

    requestManualProject(content).then(() => {
      changeInProgress(false)
      showSuccessMessageModal()
    })
  }

  return (
    <Modal
      onClose={onClose}
      open
      className={classNames('main-modal main-modal--xs', className)}
      size="small"
    >
      <div className={styles.modalBody}>
        <div className={classNames('icon-cross', styles.closeIcon)} onClick={onClose} />

        <h2>
          <span className={styles.isGreen}>Let us know </span>
          what you <br/> have in mind
        </h2>

        <Textarea
          value={content}
          onChange={(e) => changeContent(e.target.value)}
          className={styles.textarea}
          placeholder="eg. need a business card design change for one of my new colleagues"
        />

        <Button
          onClick={onSubmit}
          disabled={inProgress || !content}
        >
          Get a quote
        </Button>

        <p className={styles.description}>DesignBro typically replies in one business day</p>
      </div>
    </Modal>
  )
}

export default GetQuoteModal
