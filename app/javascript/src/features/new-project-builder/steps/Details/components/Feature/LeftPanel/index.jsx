import React from 'react'
import classNames from 'classnames'

//styles
import styles from './LeftPanel.module.scss'

const LeftPanel = ({ children, icon, isRightBorder }) => {
  return (
    <div
      className={classNames(styles.leftPanel, {
        [styles.noIcon]: !icon,
        [styles.rightBorder]: isRightBorder,
      })}
    >
      {!!icon && <img src={icon} className={styles.featureIcon} />}
      {children}
    </div>
  )
}

export default LeftPanel
