import React from 'react'
import Input from '../Input'
import styles from './Discount.module.scss'

const Discount = ({ discountCode, onChange }) => (
  <div className={styles.discount}>
    <div className={styles.label}>
      Got a discount code?
    </div>

    <div className={styles.input}>
      <Input
        inputClassName={styles.inputComponent}
        value={discountCode}
        name="discountCode"
        onChange={onChange}
      />
    </div>
  </div>
)

export default Discount
