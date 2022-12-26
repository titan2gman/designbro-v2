import React from 'react'
import PropTypes from 'prop-types'
import Input from '@components/inputs/Input'
import styles from './Discount.module.scss'

const Discount = ({ discountCode, isValid, inProgress, onChange }) => (
  <div className={styles.discount}>
    <div className={styles.label}>
      Voucher code
    </div>

    <div className={styles.input}>
      <Input
        name="discountCode"
        value={discountCode}
        label=""
        onChange={onChange}
      />
    </div>

    <div className={styles.validation}>
      {discountCode && !inProgress && isValid && <i key="valid-check" className="icon-check in-green-300 font-12 font-bold" />}
      {discountCode && !inProgress && !isValid && <i className="icon-cross in-red-500 font-12 font-bold" />}
    </div>
  </div>
)

export default Discount
