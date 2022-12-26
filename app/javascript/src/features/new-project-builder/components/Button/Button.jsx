import React from 'react'
import classNames from 'classnames'
import styles from './Button.module.scss'

const Button = ({
  disabled,
  styledAsDisabled,
  children,
  className,
  variant,
  waiting,
  add,
  added,
  ...props
}) => {
  return (
    <button
      className={classNames(styles.btn, className, {
        [styles.disabled]: disabled || styledAsDisabled,
        [styles.waiting]: waiting,
        [styles.add]: add,
        [styles.added]: add && added
      })}
      disabled={disabled}
      {...props}
    >
      {children}
    </button>
  )
}

export default Button
