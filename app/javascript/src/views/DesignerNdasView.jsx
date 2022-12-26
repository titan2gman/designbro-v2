import React, { Component } from 'react'
import { compose } from 'redux'
import { connect } from 'react-redux'

import { withDarkAppLayout } from '../layouts'
import { requireDesignerAuthentication } from '../authentication'

import { loadDesignerNdas } from '@actions/designerNdas'

import DesignerNdasList from '../containers/designer/NdasList'

const hasData = (View) => {
  return class HasData extends Component {
    componentWillMount () {
      this.props.loadDesignerNdas()
    }

    render () {
      return <View {...this.props} />
    }
  }
}

const composedHasData = compose(
  connect(null, {
    loadDesignerNdas
  }),
  hasData
)

export default compose(
  withDarkAppLayout,
  composedHasData,
  requireDesignerAuthentication
)(DesignerNdasList)
