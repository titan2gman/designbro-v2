import React, { Component } from 'react'
import { compose } from 'redux'
import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom'

import { withAppLayout } from '../layouts'
import { requireClientAuthentication } from '../authentication'

import { loadProject } from '@actions/newProject'
import { loadVatRates } from '@actions/vatRates'

import Layout from '../containers/client-project/Layout'

const hasData = (View) => {
  return class HasData extends Component {
    componentWillMount () {
      const id = this.props.match.params.id
      this.props.loadProject(id)
      this.props.loadVatRates()
    }

    render () {
      return <View {...this.props} />
    }
  }
}

const composedHasData = compose(
  connect(null, {
    loadProject,
    loadVatRates
  }),
  hasData
)

export default compose(
  withRouter,
  withAppLayout,
  composedHasData,
  requireClientAuthentication
)(Layout)
