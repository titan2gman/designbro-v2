import React from 'react'
import styles from './PaymentSummaryItem.module.scss'

const PaymentSummaryItem = ({ isVisible, name, value }) => {
  if (!isVisible) {
    return null
  }

  return (
    <div className={styles.summaryItem}>
      <span className={styles.summaryItemName}>
        {name}
      </span>

      <span className={styles.summaryItemPrice}>
        {value}
      </span>
    </div>
  )
}

export default PaymentSummaryItem
