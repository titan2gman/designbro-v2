import React from 'react'
import classNames from 'classnames'
import { Modal } from 'semantic-ui-react'
import styles from './SuccessMessageModal.module.scss'
import Button from '@components/Button'
import { history } from '../../../../history'

const SuccessMessageModal = ({ onClose, className }) => {
  return (
    <Modal
      onClose={onClose}
      open
      className={classNames('main-modal main-modal--xs', className)}
      size="small"
    >
      <div className={styles.modalBody}>
        <h2>
          <span className={styles.isGreen}>Awesome!</span>
          We'll get back <br/>
          to you shortly
        </h2>
        <Button
          variant="transparent"
          className={styles.btn}
          onClick={() => {
            onClose()
            history.push('/c')
          }}
        >
          Continue
          <i className={classNames(styles.icon, 'icon-arrow-right')} />
        </Button>
      </div>
    </Modal>
  )
}

export default SuccessMessageModal
