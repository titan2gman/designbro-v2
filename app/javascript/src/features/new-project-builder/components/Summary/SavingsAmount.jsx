import React from 'react'

//styles
import styles from './SavingsAmount.module.scss'

const SavingsAmount = ({ amount }) => (
  <div className={styles.savings}>
    You save {amount}
  </div>
)

export default SavingsAmount
