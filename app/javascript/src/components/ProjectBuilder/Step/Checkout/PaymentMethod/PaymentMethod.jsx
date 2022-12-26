import React, { useState } from 'react'
import PropTypes from 'prop-types'

import { RadioButton } from '../../../inputs'

import PayPalPaymentForm from './PayPalPaymentFormContainer'
import StripePaymentForm from './StripePaymentFormContainer'
import PaymentMethodSwitch from '../../../../inputs/PaymentMethod'

const PaymentMethod = ({
  paymentType,
  hasBillingFormWarning,
  creditCardNumber,
  creditCardProvider,
  hasCard,
  onChange
}) => {
  const [isCardFormVisible, showCardForm] = useState(false)

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
            onChange={onChange}
          />
        </span>

        <span className="prjb-radio prjb-checkout-radio main-radio">
          <RadioButton
            label="PayPal"
            value="paypal"
            name="paymentType"
            onChange={onChange}
          />
        </span>
      </div>

      {hasBillingFormWarning ? (
        <p className="in-pink-500 error">
          Please scroll top and check that all required fields have correct data.
        </p>
      ) : (
        <>
          {paymentType === 'paypal' && <PayPalPaymentForm />}

          {paymentType === 'credit_card' && (
            <StripePaymentForm
              creditCardNumber={creditCardNumber}
              creditCardProvider={creditCardProvider}
            />
          )}
        </>
      )}
    </div>
  )
}

PaymentMethod.propTypes = {
  paymentType: PropTypes.string.isRequired
}

export default PaymentMethod
