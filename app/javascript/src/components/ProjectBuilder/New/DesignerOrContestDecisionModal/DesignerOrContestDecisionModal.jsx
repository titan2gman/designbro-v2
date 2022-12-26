import React from 'react'
import classNames from 'classnames'
import { Modal } from 'semantic-ui-react'
import styles from './DesignerOrContestDecisionModal.module.scss'
import Button from '@components/Button'

const DesignerOrContestDecisionModal = ({ selectOneToOne, selectContest, className }) => {

  return (
    <Modal
      open
      className={classNames('main-modal main-modal--xs', className)}
      size="small"
      closeOnDimmerClick={false}
    >
      <div className={styles.modalBody}>
        <div className={styles.modalHeader}>
          Who do you want to work with?
        </div>

        <div className={styles.modalContent}>
          <div className={styles.block}>
            <Button variant="outlined" className={styles.button} onClick={selectOneToOne}>
              Existing designer
            </Button>
            <span className={styles.description}>
              Work with one of your previous winning designers
            </span>
          </div>
          <div className={styles.block}>
            <Button variant="outlined" className={styles.button} onClick={selectContest}>
              Contest
            </Button>
            <span className={styles.description}>
              Start a contest with multiple designers
            </span>
          </div>
        </div>
      </div>
    </Modal>
  )
}

export default DesignerOrContestDecisionModal
