import React from 'react'
import Textarea from 'react-textarea-autosize'
import cn from 'classnames'

import styles from './Textarea.module.scss'

const TextareaComponent = ({ inputClassName, ...props }) => {
  return (
    <div className={styles.inputWrapper}>
      <Textarea className={cn(styles.input, inputClassName)} {...props} />
    </div>
  )
}

export default TextareaComponent
