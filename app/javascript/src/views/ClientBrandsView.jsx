import React, { Component } from 'react'
import { compose } from 'redux'
import { connect } from 'react-redux'

import { withAppLayout } from '../layouts'
import { requireClientAuthentication } from '../authentication'

import { loadBrands } from '@actions/brands'

import ClientBrandsPage from '../components/ClientBrandsPage'

const hasData = (View) => {
  return class HasData extends Component {
    componentWillMount () {
      this.props.loadBrands()
    }

    render () {
      return <View {...this.props} />
    }
  }
}

const composedHasData = compose(
  connect(null, {
    loadBrands
  }),
  hasData
)

export default compose(
  withAppLayout,
  composedHasData,
  requireClientAuthentication
)(ClientBrandsPage)
