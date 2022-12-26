import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { compose } from 'redux'
import { connect } from 'react-redux'

import { withAppLayout } from '../layouts'

import { loadProducts } from '@actions/products'

import InitialStep from '@components/ProjectBuilder/InitialStep'

const hasData = (View) => {
  return class HasData extends Component {
    componentWillMount () {

      this.props.loadProducts()
    }

    render () {
      return <View {...this.props} />
    }
  }
}

const composedHasData = compose(
  connect(null, {
    loadProducts,
  }),
  hasData
)

export default compose(
  withAppLayout,
  composedHasData
)(InitialStep)
