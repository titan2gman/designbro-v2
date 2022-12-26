import _ from 'lodash'
import React from 'react'
import cn from 'classnames'

import Input from '../Input'

import scorePassword from '@utils/scorePassword'

import styles from './PasswordInput.module.scss'

function getLevel(score) {
  if (score > 60) {
    return 'strong'
  } else if (score > 25) {
    return 'fair'
  }

  return 'weak'
}

const StatusLine = ({ score }) => {
  const level = getLevel(score)
  return (
    <div>
      <span className={cn(styles.passwordStrengthDot, styles[level])} />
      <span className={styles.passwordStrength}>{_.capitalize(level)} Pass</span>
    </div>
  )
}

const PasswordInput = ({ value, statusLine, ...props }) => {
  return (
    <div className={styles.inputWrapper}>
      <Input value={value} {...props} />

      {statusLine && value && <StatusLine score={scorePassword(value)} />}
    </div>
  )
}

export default PasswordInput
