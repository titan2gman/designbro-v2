import { connect } from 'react-redux'

import { changePage, loadDiscoverProjects } from '@actions/projects'

import {
  getPrize,
  getSpotState,
  getProjectType
} from '@reducers/projects'

import Pager from '@components/Pager'

const mapStateToProps = (state, props) => {
  const { pager } = state.projects

  return {
    total: pager.totalPages,
    current: pager.currentPage,
    sort: getPrize(props.prizeFilter),
    project_type_eq: getProjectType(props.type),
    spots_state: getSpotState(props.stateFilter)
  }
}

const mergeProps = (stateProps, dispatchProps, ownProps) => {
  const { dispatch } = dispatchProps

  return {
    ...stateProps,
    ...dispatchProps,
    ...ownProps,

    onClick: (page) => [
      dispatch(changePage(page)),
      dispatch(loadDiscoverProjects(stateProps))
    ]
  }
}

export default connect(mapStateToProps, null, mergeProps)(Pager)
