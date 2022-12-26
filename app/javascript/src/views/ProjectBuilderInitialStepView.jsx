import React, { Component } from 'react'
import { compose } from 'redux'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'

import { withAppLayout } from '../layouts'

import InitialStep from '../components/ProjectBuilder/New'

import { changeAttributes } from '@actions/projectBuilder'
import { loadAllBrands } from '@actions/brands'
import { loadProducts } from '@actions/products'
import { loadFinalistDesigners } from '@actions/finalistDesigners'
import { loadVatRates } from '@actions/vatRates'

const hasData = (View) => {
  return class HasData extends Component {
    componentWillMount () {
      const { loadProducts, loadFinalistDesigners, loadAllBrands, loadVatRates } = this.props

      loadProducts()
      loadFinalistDesigners()
      loadAllBrands()
      loadVatRates()
    }

    render () {
      return <View {...this.props} />
    }
  }
}

const composedHasData = compose(
  connect(null, {
    loadAllBrands,
    loadProducts,
    loadFinalistDesigners,
    loadVatRates,
    changeAttributes
  }),
  hasData
)

export default compose(
  withAppLayout,
  composedHasData
)(InitialStep)
