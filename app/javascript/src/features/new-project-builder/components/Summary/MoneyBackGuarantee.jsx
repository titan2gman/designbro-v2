import React from 'react'
import MoneyBackGuaranteeModal from '../MoneyBackGuaranteeModal'

//styles
import styles from './MoneyBackGuarantee.module.scss'

export const MoneyBackGuarantee = () => {
  return (
    <div className={styles.moneyBackGuarantee}>
      <div className={styles.icon} />
      <div className={styles.content}>
        <h3 className={styles.title}>Money back guarantee</h3>
        <p className={styles.text}>
          99% happy customers. We want to keep it that way. Conditions apply -
          See our {(
            <MoneyBackGuaranteeModal
              trigger={<span className={styles.link}>refund policy</span>}
            />
          )}
        </p>
      </div>
    </div>
  )
}
