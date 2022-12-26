import React, { Component } from 'react'
import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom'
import { updateProjectWithStripePayment } from '@actions/projectBuilder'
import { getProjectBuilderStep } from '@selectors/projectBuilder'

import StripePaymentForm from '../../../StripePaymentForm'

class StripePaymentFormContainer extends Component {
  handleSubmit = (paymentMethod) => {
    const { openStep, updateProjectWithStripePayment } = this.props

    return updateProjectWithStripePayment(openStep, paymentMethod)
  }

  render () {
    return (
      <StripePaymentForm
        {...this.props}
        onSuccess={this.handleSubmit}
      />
    )
  }
}

const mapStateToProps = (state, { match }) => {
  const stepName = match.params.step
  const openStep = getProjectBuilderStep(state, stepName)

  return {
    openStep
  }
}

export default withRouter(connect(mapStateToProps, {
  updateProjectWithStripePayment
})(StripePaymentFormContainer))
