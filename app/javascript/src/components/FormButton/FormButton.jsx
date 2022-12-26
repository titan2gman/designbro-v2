import React from 'react'
import classNames from 'classnames'
import styles from './FormButton.module.scss'

const FormButton = ({ children, className, ...props }) => {
  return (
    <button
      className={classNames(styles.formButton, className)}
      {...props}
    >
      {children}
    </button>
  )
}

export default FormButton
