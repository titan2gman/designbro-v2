import React from 'react'
import styles from './Headline.module.scss'
import cn from 'classnames'

const Headline = ({ children, className }) => {
  return (
    <h1 className={cn(styles.headline, className)}>
      {children}
    </h1>
  )
}

export default Headline
