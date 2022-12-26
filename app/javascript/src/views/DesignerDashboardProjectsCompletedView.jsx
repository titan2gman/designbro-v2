import React, { Component } from 'react'

import { compose } from 'redux'
import { connect } from 'react-redux'

import { loadMyProjects } from '@actions/projects'
import { loadProductCategories } from '@actions/productCategories'

import { withDarkAppLayout } from '../layouts'

import { requireDesignerAuthentication } from '../authentication'

import DesignerDashboardProjectsInProgress from '../containers/designer-dashboard/DesignerDashboardProjects'

const hasData = (View) => {
  return class HasData extends Component {
    componentWillMount () {
      this.props.loadProductCategories()
      this.props.loadMyProjects('completed')
    }

    render () {
      return <View {...this.props} />
    }
  }
}

const composedHasData = compose(
  connect(null, {
    loadProductCategories,
    loadMyProjects
  }),
  hasData
)

export default compose(
  withDarkAppLayout,
  composedHasData,
  requireDesignerAuthentication
)(DesignerDashboardProjectsInProgress)
