import React from 'react'

import styles from './Footer.module.scss'

const Footer = ({ backButton, continueButton, validation }) => {
  return (
    <div className={styles.footer}>
      <div className={styles.backButtonWrapper}>
        {backButton}
      </div>
      <div className={styles.continueButtonWrapper}>
        {continueButton}
      </div>
      <div className={styles.validationWrapper}>
        {validation}
      </div>
    </div>
  )
}

export default Footer
