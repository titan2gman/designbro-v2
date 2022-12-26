import React, { useState } from 'react'
import classNames from 'classnames'
import { Modal } from 'semantic-ui-react'
import styles from './UpsellModal.module.scss'
import Button from '@components/Button'

const UpsellModal = ({
  id,
  title,
  count,
  minCount,
  maxCount,
  totalCost,
  onUp,
  onDown,
  onContinue,
  onClose
}) => {
  return (
    <Modal
      open
      className={classNames('main-modal main-modal--xs')}
      size="tiny"
      onClose={onClose}
    >
      <div className={styles.modalBody}>
        {onClose && <div className={classNames('icon-cross', styles.closeIcon)} onClick={onClose} />}

        <div className={styles.modalHeader}>
          <h2>{title}</h2>
        </div>

        <div className={styles.modalContent}>
          <div>
            <button
              className={styles.buttonUp}
              disabled={count >= maxCount}
              onClick={onUp}
            />
          </div>

          <div className={styles.count}>{count}</div>

          <div>
            <button
              className={styles.buttonDown}
              disabled={count <= minCount}
              onClick={onDown}
            />
          </div>

          <div className={styles.totalCost}>
            Total cost <span className={styles.totalCostValue}>{totalCost}</span>
          </div>

          <Button
            className={styles.continueBtn}
            onClick={onContinue}
          >
            Continue
            <i className={classNames(styles.icon, 'icon-arrow-right')} />
          </Button>
        </div>
      </div>
    </Modal>
  )
}

export default UpsellModal
