import React, { Component } from 'react'
import PropTypes from 'prop-types'

import { withAppLayout } from '../layouts'

import SuccessStep from '../components/ProjectBuilder/Step/Success'

import { compose } from 'redux'
import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom'

import { loadProject } from '@actions/projectBuilder'

const hasData = (View) => {
  return class HasData extends Component {
    componentWillMount () {
      const id = this.props.match.params.id
      this.props.loadProject(id)
    }

    render () {
      return <View {...this.props} />
    }
  }
}

const composedHasData = compose(
  connect(null, {
    loadProject
  }),
  hasData
)

export default compose(
  withAppLayout,
  withRouter,
  composedHasData
)(SuccessStep)
