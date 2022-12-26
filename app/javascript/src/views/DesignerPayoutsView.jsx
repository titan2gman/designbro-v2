import React, { Component } from 'react'
import { compose } from 'redux'
import { connect } from 'react-redux'

import { withDarkAppLayout } from '../layouts'
import { requireDesignerAuthentication } from '../authentication'

import { loadPayouts } from '@actions/payouts'
import { loadPayoutMinAmounts } from '@actions/payoutMinAmounts'

import DesignerPayouts from '../containers/designer/Payouts'

const hasData = (View) => {
  return class HasData extends Component {
    componentWillMount () {
      this.props.loadPayouts()
      this.props.loadPayoutMinAmounts()
    }

    render () {
      return <View {...this.props} />
    }
  }
}

const composedHasData = compose(
  connect(null, {
    loadPayouts,
    loadPayoutMinAmounts
  }),
  hasData
)

export default compose(
  withDarkAppLayout,
  composedHasData,
  requireDesignerAuthentication
)(DesignerPayouts)
