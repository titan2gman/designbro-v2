import React from 'react'
import cn from 'classnames'
import { useSelector } from 'react-redux'
import PropTypes from 'prop-types'

import styles from './ProgressBar.module.scss'

const ProgressBar = ({ progressPercentage, successThreshold, className }) => {
  return (
    <div className={cn(styles.progressBar, className, {})}>
      <div className={cn(styles.progress, { [styles.success]: successThreshold && progressPercentage >= successThreshold })} style={{ right: `${100 - (progressPercentage || 4)}%` }} />
    </div>
  )
}

ProgressBar.defaultProps = {
  progressPercentage: 10
}

export default ProgressBar
