import React, { Component } from 'react'
import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom'
import { updateProjectWithPaypalPayment } from '@actions/projectBuilder'
import { totalPriceWithVatSelector } from '@selectors/vat'
import { getProjectBuilderStep } from '@selectors/projectBuilder'

import PaypalPaymentForm from '../../../PaypalPaymentForm'

class PaypalPaymentFormContainer extends Component {
  handleSubmit = (paymentMethod) => {
    const { openStep, updateProjectWithPaypalPayment } = this.props

    return updateProjectWithPaypalPayment(openStep, paymentMethod)
  }

  render () {
    return (
      <PaypalPaymentForm
        amount={this.props.amount}
        onSuccess={this.handleSubmit}
      />
    )
  }
}

const mapStateToProps = (state, { match }) => {
  const stepName = match.params.step
  const openStep = getProjectBuilderStep(state, stepName)

  return {
    amount: totalPriceWithVatSelector(state).toRoundedUnit(2),
    openStep
  }
}

export default withRouter(connect(mapStateToProps, {
  updateProjectWithPaypalPayment
})(PaypalPaymentFormContainer))
