import React, { Component } from 'react'
import { compose } from 'redux'
import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom'

import { withDarkAppLayout } from '../layouts'
import { requireDesignerAuthentication } from '../authentication'

import { loadProject } from '@actions/newProject'

import ProjectBrief from '../containers/designer-project/ProjectBrief'

const hasData = (View) => {
  return class HasData extends Component {
    componentWillMount () {
      const { match, loadProject } = this.props
      const id = match.params.id

      loadProject(id)
    }

    render () {
      return <View {...this.props} />
    }
  }
}

const composedHasData = compose(
  connect(null, {
    loadProject,
  }),
  hasData
)

export default compose(
  withRouter,
  withDarkAppLayout,
  composedHasData,
  requireDesignerAuthentication
)(ProjectBrief)
