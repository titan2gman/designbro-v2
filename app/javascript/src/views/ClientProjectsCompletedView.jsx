import React, { Component } from 'react'
import { compose } from 'redux'
import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom'

import { withAppLayout } from '../layouts'
import { requireClientAuthentication } from '../authentication'

import { loadBrand } from '@actions/brands'

import ProjectsCompletedList from '../containers/client-brands/ProjectsCompletedList'

const hasData = (View) => {
  return class HasData extends Component {
    componentWillMount () {
      const id = this.props.match.params.id
      this.props.loadBrand(id)
    }

    render () {
      return <View {...this.props} />
    }
  }
}

const composedHasData = compose(
  connect(null, {
    loadBrand
  }),
  hasData
)

export default compose(
  withRouter,
  withAppLayout,
  composedHasData,
  requireClientAuthentication
)(ProjectsCompletedList)
