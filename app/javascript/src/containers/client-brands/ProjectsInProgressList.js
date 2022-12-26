import _ from 'lodash'
import { connect } from 'react-redux'
import { compose } from 'redux'
import { withSpinner } from '@components/withSpinner'

import ProjectsInProgressList from '@components/client-brands/ProjectsInProgressList'

import { groupedByStateProjectsSelector } from '@selectors/projects'

const mapStateToProps = (state, props) => {
  const id = props.match.params.id

  return {
    brand: _.get(state.entities.brands, id),
    groupedProjects: groupedByStateProjectsSelector(id)(state),
    inProgress: state.brands.inProgress
  }
}

export default compose(
  connect(mapStateToProps),
  withSpinner,
)(ProjectsInProgressList)
