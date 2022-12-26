import React from 'react'

//styles
import styles from './Total.module.scss'

export const Total = ({ price }) => {
  return (
    <div className={styles.total}>
      <h2 className={styles.totalCaption}>Total</h2>
      <h2 className={styles.totalPrice}>
        {price}
      </h2>
    </div>
  )
}
