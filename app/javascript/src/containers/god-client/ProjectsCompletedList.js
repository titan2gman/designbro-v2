import _ from 'lodash'
import { connect } from 'react-redux'
import { compose } from 'redux'
import { withSpinner } from '@components/withSpinner'
import { loadProjects } from '@actions/projects'

import ProjectsCompletedList from '@components/client-brands/ProjectsCompletedList'

import { getProjects } from '../../reducers/projects'

const mapStateToProps = (state, props) => {
  return {
    groupedProjects: {
      'Completed': getProjects(state)
    },
    inProgress: state.projects.inProgress
  }
}

export default compose(
  connect(mapStateToProps, {
    loadProjects
  }),
  withSpinner,
)(ProjectsCompletedList)
