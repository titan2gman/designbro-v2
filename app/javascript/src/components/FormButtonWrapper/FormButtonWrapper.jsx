import React from 'react'
import classNames from 'classnames'
import styles from './FormButtonWrapper.module.scss'

const FormButtonWrapper = ({ children, className }) => {
  return (
    <div
      className={classNames(styles.formButtonWrapper, className)}
    >
      {children}
    </div>
  )
}

export default FormButtonWrapper
