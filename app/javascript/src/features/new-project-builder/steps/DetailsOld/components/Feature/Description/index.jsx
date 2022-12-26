import React from 'react'
import classNames from 'classnames'

//styles
import styles from './Description.module.scss'

const Description = ({ title, isDesignCount, children }) => {
  return (
    <div>
      <h2 className={styles.title}>{title}</h2>
      <p
        className={classNames(styles.detailDescription, {
          [styles.designsCount]: isDesignCount,
        })}
      >
        {children}
      </p>
    </div>
  )
}

export default Description
