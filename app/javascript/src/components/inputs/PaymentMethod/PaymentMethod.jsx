import React from 'react'
import classNames from 'classnames'
import styles from './PaymentMethod.module.scss'

const PaymentMethod = ({ creditCardNumber, creditCardProvider, onChange }) => (
  <div className={styles.paymentMethodBlock}>
    <div className={classNames(styles.paymentMethod, styles[creditCardProvider])} />

    <div className={styles.cardNumber}>
      XXXX XXXX XXXX {creditCardNumber}
    </div>

    <div className={styles.paymentHint}>
      &#9666;&nbsp;
      <button className={styles.switchPayment} onClick={onChange}>Change</button>
    </div>
  </div>
)

export default PaymentMethod
