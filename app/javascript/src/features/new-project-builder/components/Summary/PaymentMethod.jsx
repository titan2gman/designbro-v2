import React from 'react'
import classNames from 'classnames'

//styles
import styles from './PaymentMethod.module.scss'

export const PaymentMethod = () => {
  return (
    <div className={styles.paymentMethods}>
      <p className={styles.title}>Payment methods accepted</p>
      <div className={classNames(styles.paymentMethod, styles.visa)} />
      <div className={classNames(styles.paymentMethod, styles.americanExpress)} />
      <div className={classNames(styles.paymentMethod, styles.mastercard)} />
    </div>
  )
}
