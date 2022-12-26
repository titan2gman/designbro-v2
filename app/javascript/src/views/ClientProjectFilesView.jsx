import React, { Component } from 'react'
import { compose } from 'redux'
import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom'

import { loadReviewsByDesignerId } from '@actions/reviews'
import { loadSourceFiles } from '@actions/sourceFiles'

import { getCurrentProject } from '../selectors/projects'

import Files from '../containers/client-project/Files'

const hasData = (View) => {
  return class HasData extends Component {
    componentWillMount () {
      const id = this.props.match.params.id
      const { project, loadReviewsByDesignerId, loadSourceFiles } = this.props

      loadReviewsByDesignerId(project.winner)
      loadSourceFiles(id)
    }

    render () {
      return <View {...this.props} />
    }
  }
}

const mapStateToProps = (state) => {
  return {
    project: getCurrentProject(state)
  }
}

const composedHasData = compose(
  connect(mapStateToProps, {
    loadReviewsByDesignerId,
    loadSourceFiles
  }),
  hasData
)

export default compose(
  withRouter,
  composedHasData
)(Files)
