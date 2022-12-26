import React, { Component } from 'react'
import { compose } from 'redux'
import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom'

import { withDarkAppLayout } from '../layouts'
import { requireDesignerAuthentication } from '../authentication'

import { loadProject } from '@actions/newProject'
import { loadSourceFiles } from '@actions/sourceFiles'

import ProjectFiles from '../containers/designer-project/ProjectFiles'

const hasData = (View) => {
  return class HasData extends Component {
    componentWillMount () {
      const { match, loadProject, loadSourceFiles } = this.props
      const id = match.params.id

      loadProject(id)
      loadSourceFiles(id)
    }

    render () {
      return <View {...this.props} />
    }
  }
}

const composedHasData = compose(
  connect(null, {
    loadProject,
    loadSourceFiles
  }),
  hasData
)

export default compose(
  withRouter,
  withDarkAppLayout,
  composedHasData,
  requireDesignerAuthentication
)(ProjectFiles)
