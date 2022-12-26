import React from 'react'
import classNames from 'classnames'

//styles
import styles from './RightPanel.module.scss'

const RightPanel = ({ children, isDesignerCounter }) => {
  return (
    <div
      className={classNames(styles.rightPanel, {
        [styles.leftBorder]: isDesignerCounter,
      })}
    >
      {children}
    </div>
  )
}

export default RightPanel
