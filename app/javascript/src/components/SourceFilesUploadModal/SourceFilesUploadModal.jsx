import React, { Fragment, useState } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import { Modal } from 'semantic-ui-react'
import CheckListForm from './CheckListForm'
import FeaturedImageForm from './FeaturedImageForm'
import UploadFilesForm from './UploadFilesForm'

import styles from './SourceFilesUploadModal.module.scss'

const steps = [
  'Delivery checklist',
  'Featured image',
  'Upload files'
]

const SourceFilesUploadModal = ({ onClose, callback, className }) => {
  const [currentStep, setCurrentStep] = useState(0)

  return (
    <Modal
      onClose={onClose}
      open
      className={classNames('main-modal main-modal--xs', className)}
      size="small"
    >
      <div className={styles.modalContent}>
        <div className={styles.modalHeader}>
          Upload files
        </div>

        <div className={styles.stepper}>
          {steps.map((stepName, index) => {
            return (
              <Fragment key={index}>
                <div className={classNames(styles.stepItem, { [styles.active]: currentStep === index })}>
                  {stepName}
                </div>
                <div className={styles.stepDivider}>
                  &#9654;
                </div>
              </Fragment>
            )
          })}
        </div>

        {currentStep === 0 && (<CheckListForm onSubmit={() => { setCurrentStep(1) }} />)}
        {currentStep === 1 && (<FeaturedImageForm onSubmit={() => { setCurrentStep(2) }} />)}
        {currentStep === 2 && (<UploadFilesForm onSubmit={() => { onClose(); callback && callback() }} />)}
      </div>
    </Modal>
  )
}

export default SourceFilesUploadModal
