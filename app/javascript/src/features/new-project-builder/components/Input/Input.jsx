import React from 'react'
import cn from 'classnames'

import styles from './Input.module.scss'

const Input = ({ append, inputClassName, appendClassName, error, ...props }) => {
  return (
    <div className={styles.inputWrapper}>
      <input className={cn(styles.input, inputClassName, { [styles.hasAppend]: !!append })} {...props} />

      {!!append && <div className={cn(styles.append, appendClassName)}>{append}</div>}

      {error && <div className={styles.error}>{error}</div>}
    </div>
  )
}

export default Input
