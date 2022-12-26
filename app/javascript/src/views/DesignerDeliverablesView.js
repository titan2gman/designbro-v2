import React, { Component } from 'react'
import _ from 'lodash'
import { compose } from 'redux'
import { connect } from 'react-redux'

import { showDeliverablesModal } from '@actions/modal'
import { loadProductCategories } from '@actions/productCategories'

import { withAppLayout } from '../layouts'
import { requireDesignerAuthentication } from '../authentication'

import DesignerDeliverables from '../containers/designer/DesignerDeliverables'


const hasData = (View) => {
  return class HasData extends Component {

    componentWillMount () {
      this.props.loadProductCategories()
    }

    render () {
      return <View {...this.props} />
    }
  }
}

const composedHasData = compose(
  connect(null, {
    loadProductCategories,
  }),
  hasData
)

export default compose(
  withAppLayout,
  composedHasData,
  requireDesignerAuthentication
)(DesignerDeliverables)
