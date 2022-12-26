import React, { Component } from 'react'
import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom'
import { saveStep } from '@actions/projectBuilder'
import { getProjectBuilderStep, getProjectBuilderAttributes } from '@selectors/projectBuilder'
import { getMe } from '@selectors/me'

import PaymentMethod from './PaymentMethod'

class PaymentMethodContainer extends Component {
  handleChange = () => {
    const { openStep, saveStep } = this.props

    saveStep(openStep)
  }

  render () {
    return (
      <PaymentMethod
        {...this.props}
        onChange={this.handleChange}
        onSuccess={this.handleSubmit}
      />
    )
  }
}

const mapStateToProps = (state, { match }) => {
  const me = getMe(state)
  const { creditCardNumber, creditCardProvider } = me

  const stepName = match.params.step
  const openStep = getProjectBuilderStep(state, stepName)

  const attributes = getProjectBuilderAttributes(state)

  return {
    openStep,
    paymentType: attributes.paymentType,
    hasBillingFormWarning: !(attributes.firstName && attributes.lastName && attributes.countryCode),
    creditCardNumber,
    creditCardProvider,
    hasCard: creditCardNumber && creditCardProvider,
  }
}

export default withRouter(connect(mapStateToProps, {
  saveStep
})(PaymentMethodContainer))
