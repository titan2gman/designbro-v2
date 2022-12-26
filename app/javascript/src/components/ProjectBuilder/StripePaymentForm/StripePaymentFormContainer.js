import React from 'react'
import { connect } from 'react-redux'
import { Elements } from 'react-stripe-elements'
import StripePaymentForm from './StripePaymentForm'

const StripePaymentFormContainer = (props) => {
  return (
    <Elements>
      <StripePaymentForm
        {...props}
      />
    </Elements>
  )
}

export default StripePaymentFormContainer
