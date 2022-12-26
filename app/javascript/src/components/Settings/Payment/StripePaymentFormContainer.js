import _ from 'lodash'
import React, { Component } from 'react'
import { connect } from 'react-redux'
import { saveStripePaymentSettings } from '@actions/client'

import StripePaymentForm from '../../ProjectBuilder/StripePaymentForm'

class StripePaymentFormContainer extends Component {
  handleSubmit = (paymentMethod) => {
    const { saveStripePaymentSettings } = this.props

    return saveStripePaymentSettings(paymentMethod)
  }

  render () {
    return (
      <StripePaymentForm
        onSuccess={this.handleSubmit}
        buttonText="Save"
        creditCardNumber={this.props.creditCardNumber}
        creditCardProvider={this.props.creditCardProvider}
      />
    )
  }
}

const mapStateToProps = (state) => {
  const { creditCardNumber, creditCardProvider } = state.me.me

  return {
    creditCardNumber,
    creditCardProvider: _.kebabCase(creditCardProvider)
  }
}

export default connect(mapStateToProps, {
  saveStripePaymentSettings
})(StripePaymentFormContainer)
