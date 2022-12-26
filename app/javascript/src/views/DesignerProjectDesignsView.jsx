import React, { Component } from 'react'
import { compose } from 'redux'
import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom'
import { parse } from 'query-string'

import { withDarkAppLayout } from '../layouts'
import { requireDesignerAuthentication } from '../authentication'

import { loadProject } from '@actions/newProject'

import ProjectDesigns from '../containers/designer-project/ProjectDesigns'

const hasData = (View) => {
  return class HasData extends Component {
    componentWillMount () {
      const id = this.props.match.params.id
      const designIdParam = parse(this.props.location.search).design_id

      this.props = {
        ...this.props,
        designIdParam
      }
      this.props.loadProject(id)
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
)(ProjectDesigns)
