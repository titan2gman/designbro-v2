import React, { Component } from 'react'

import BackButton from '../BackButton'
import styles from './SubmitPanel.module.scss'

const SubmitPanel = ({ isBackButtonVisible, onBackButtonClick, children }) => {
  return (
    <div className={styles.wrapper}>
      {isBackButtonVisible && <BackButton onClick={onBackButtonClick} />}

      {children}
    </div>
  )
}

SubmitPanel.defaultProps = {
  isBackButtonVisible: true
}

export default SubmitPanel
