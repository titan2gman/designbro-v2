import React, { Component } from 'react'

import { compose } from 'redux'
import { connect } from 'react-redux'

import { loadProductCategories } from '@actions/productCategories'

import { withDesignerSignupLayout } from '../layouts'

import { requireDesignerAuthentication } from '../authentication'

import SignupDesignerProfileStep from '../containers/signup/DesignerProfileStep'

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
    loadProductCategories
  }),
  hasData
)

export default compose(
  withDesignerSignupLayout,
  composedHasData,
  requireDesignerAuthentication
)(SignupDesignerProfileStep)
