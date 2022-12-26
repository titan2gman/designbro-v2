import React, { Component } from 'react'

import { compose } from 'redux'
import { connect } from 'react-redux'

import { loadProjects, changePage } from '@actions/projects'

import { withAppLayout } from '../layouts'

import { requireGodClientAuthentication } from '../authentication'

import ProjectsInProgressList from '../containers/god-client/ProjectsInProgressList'

const hasData = (View) => {
  return class HasData extends Component {
    componentWillMount () {
      this.props.changePage(1)

      this.props.loadProjects({
        state_in: ['design_stage', 'finalist_stage', 'files_stage', 'review_files']
      })
    }

    render () {
      return <View {...this.props} />
    }
  }
}

const composedHasData = compose(
  connect(null, {
    loadProjects,
    changePage
  }),
  hasData
)

export default compose(
  withAppLayout,
  composedHasData,
  requireGodClientAuthentication
)(ProjectsInProgressList)
