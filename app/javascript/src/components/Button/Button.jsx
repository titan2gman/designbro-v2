import React from 'react'
import classNames from 'classnames'
import styles from './Button.module.scss'

const Button = ({ children, className, variant, waiting, ...props }) => {
  return (
    <button
      className={classNames(styles.btn, className, {
        [styles.outlined]: variant === 'outlined',
        [styles.transparent]: variant === 'transparent',
        [styles.waiting]: waiting
      })}
      {...props}
    >
      {children}
    </button>
  )
}

export default Button
