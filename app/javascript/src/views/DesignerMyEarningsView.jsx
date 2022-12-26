import React, { Component } from 'react'
import { compose } from 'redux'
import { connect } from 'react-redux'

import { withDarkAppLayout } from '../layouts'
import { requireDesignerAuthentication } from '../authentication'

import { loadEarnings } from '@actions/earnings'
import { loadPayoutMinAmounts } from '@actions/payoutMinAmounts'

import DesignerMyEarnings from '../containers/designer/MyEarnings'

const hasData = (View) => {
  return class HasData extends Component {
    componentWillMount () {
      this.props.loadEarnings()
      this.props.loadPayoutMinAmounts()
    }

    render () {
      return <View {...this.props} />
    }
  }
}

const composedHasData = compose(
  connect(null, {
    loadEarnings,
    loadPayoutMinAmounts
  }),
  hasData
)

export default compose(
  withDarkAppLayout,
  composedHasData,
  requireDesignerAuthentication
)(DesignerMyEarnings)
