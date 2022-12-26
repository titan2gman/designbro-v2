import React from 'react'
import { Select } from 'semantic-ui-react'
import cn from 'classnames'

import styles from './Select.module.scss'

const SelectComponent = ({ error, inputClassName, ...props }) => {
  return (

    <div className={cn('main-input', 'main-dropdown', styles.inputWrapper)}>
      <Select
        {...props}
      />

      {error && <div className={styles.error}>{error}</div>}
    </div>
  )
}

export default SelectComponent
