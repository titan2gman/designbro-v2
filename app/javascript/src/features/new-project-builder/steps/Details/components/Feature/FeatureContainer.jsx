import React from 'react'

//styles
import styles from './FeatureContainer.module.scss'

const FeatureContainer = ({ children }) => {
  return (
    <div className={styles.featureContainer}>
      {children}
    </div>
  )
}

export default FeatureContainer
