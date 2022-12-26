import React, { Component } from 'react'
import { compose } from 'redux'
import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom'

import { withAppLayout } from '../layouts'
import { requireClientAuthentication } from '../authentication'

import { loadBrand } from '@actions/brands'
import { loadVatRates } from '@actions/vatRates'

import ProjectsInProgressList from '../containers/client-brands/ProjectsInProgressList'

const hasData = (View) => {
  return class HasData extends Component {
    componentWillMount () {
      const id = this.props.match.params.id
      this.props.loadBrand(id)
      this.props.loadVatRates()
    }

    render () {
      return <View {...this.props} />
    }
  }
}

const composedHasData = compose(
  connect(null, {
    loadBrand,
    loadVatRates
  }),
  hasData
)

export default compose(
  withRouter,
  withAppLayout,
  composedHasData,
  requireClientAuthentication
)(ProjectsInProgressList)
