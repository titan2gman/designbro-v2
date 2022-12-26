import React, { Component } from 'react'

import { compose } from 'redux'
import { connect } from 'react-redux'

import { loadProductCategories } from '@actions/productCategories'
import { loadDiscoverProjects } from '@actions/projects'

import { withDarkAppLayout } from '../layouts'

import { requireDesignerAuthentication } from '../authentication'

import DesignerDashboardDiscover from '../containers/designer-dashboard/DesignerDashboardDiscover'

const hasData = (View) => {
  return class HasData extends Component {
    componentWillMount () {
      this.props.loadProductCategories()
      this.props.loadDiscoverProjects({
        product_category_id: this.props.match.params.product_category_id
      })
    }

    render () {
      return <View {...this.props} />
    }
  }
}

const composedHasData = compose(
  connect(null, {
    loadDiscoverProjects,
    loadProductCategories
  }),
  hasData
)

export default compose(
  withDarkAppLayout,
  composedHasData,
  requireDesignerAuthentication
)(DesignerDashboardDiscover)
