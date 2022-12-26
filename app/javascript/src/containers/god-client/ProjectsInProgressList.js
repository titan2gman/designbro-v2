import _ from 'lodash'
import { connect } from 'react-redux'
import { compose } from 'redux'
import { withSpinner } from '@components/withSpinner'
import { loadProjects } from '@actions/projects'

import ProjectsInProgressList from '@components/client-brands/ProjectsInProgressList'

import { getProjects } from '../../reducers/projects'

const mapStateToProps = (state, props) => {
  return {
    groupedProjects: {
      'In progress': getProjects(state)
    },
    inProgress: state.projects.inProgress
  }
}

export default compose(
  connect(mapStateToProps, {
    loadProjects
  }),
  withSpinner,
)(ProjectsInProgressList)
