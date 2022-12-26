import React, { useState } from 'react'
import Button from '@components/Button'
import RadioButton from './RadioButtonContainer'

import StripePaymentForm from './StripePaymentFormContainer'

import styles from './PaymentSettings.module.scss'

const PaymentSettings = ({ paymentType, onSave }) => {
  return (
    <div className="m-b-30">
      <p className="font-bold m-b-35">
        Payment Method:
      </p>

      <div className="m-b-20">
        <span className="prjb-radio prjb-checkout-radio main-radio">
          <RadioButton
            label="Credit card"
            value="credit_card"
            name="paymentType"
            checked={paymentType === 'credit_card'}
          />
        </span>

        <span className="prjb-radio prjb-checkout-radio main-radio">
          <RadioButton
            label="PayPal"
            value="paypal"
            name="paymentType"
            checked={paymentType === 'paypal'}
          />
        </span>
      </div>

      {paymentType === 'credit_card' && <StripePaymentForm />}

      {paymentType === 'paypal' && (
        <Button className={styles.btn} onClick={() => onSave()}>
          Save
        </Button>
      )}
    </div>
  )
}

export default PaymentSettings
