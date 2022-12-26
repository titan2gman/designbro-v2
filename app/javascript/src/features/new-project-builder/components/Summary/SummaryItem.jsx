import React from 'react'

//components
import Price from '../Price'

//styles
import styles from './SummaryItem.module.scss'

const SummaryItem = ({ isVisible, name, amount, isFree }) => {
  if (!isVisible) {
    return null
  }
  
  return (
    <div className={styles.summaryItem}>
      <span className={styles.summaryItemName}>
        {name}
      </span>
      <Price isFree={isFree} price={amount} isTotal={true}/>
    </div>
  )
}


export default SummaryItem
