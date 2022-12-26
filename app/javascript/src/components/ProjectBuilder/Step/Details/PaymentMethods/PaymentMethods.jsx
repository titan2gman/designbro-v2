import React from 'react'

const PaymentMethods = () => {
  return (
    <div className="payment-methods">
      <p>Payment methods accepted</p>

      <div className="payment-method visa" />
      <div className="payment-method american-express" />
      <div className="payment-method mastercard" />
      <div className="payment-method paypal" />
    </div>
  )
}

export default PaymentMethods
