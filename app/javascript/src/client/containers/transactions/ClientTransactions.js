import { connect } from 'react-redux'
import React, { Component } from 'react'

import { loadPayments } from '@actions/payments'
import { getPayments, getLoading } from '@reducers/payments'

import ClientPayments from '@client/components/transactions/ClientTransactions'

class Container extends Component {
  componentDidMount () {
    this.props.onLoad()
  }

  render () {
    return <ClientPayments {...this.props} />
  }
}

const mapStateToProps = (state) => ({
  payments: getPayments(state),
  loading: getLoading(state)
})

export default connect(mapStateToProps, {
  onLoad: loadPayments
})(Container)
