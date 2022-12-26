import React from 'react'
import _ from 'lodash'
import classNames from 'classnames'
import styles from './ErrorMessage.module.scss'

const ErrorMessage = ({ className, error }) => {
  if (!error) return null

  return (
    <div
      className={classNames(className, styles.errorMessage)}
    >
      {_.get(error, 'message')}
    </div>
  )
}

export default ErrorMessage
