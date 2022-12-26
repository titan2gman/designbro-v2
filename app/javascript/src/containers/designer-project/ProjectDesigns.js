import { compose } from 'redux'
import { connect } from 'react-redux'

import { withSpinner } from '@components/withSpinner'
import { uploadDesign } from '@actions/designs'
import { reserveSpot, joinQueue } from '@actions/projects'

import { getMe } from '@reducers/me'
import { getCurrentProjectWinner, getMySpot } from '@reducers/spots'
import { getProjectById, getProjectLoaded } from '@reducers/projects'
import { getDesignById, getMyDesigns, getDesignLoaded } from '@reducers/designs'
import { getCurrentProject } from '@selectors/projects'
import { getCurrentBrand } from '@selectors/brands'
import { getCurrentBrandDna } from '@selectors/brandDnas'

import ProjectDesigns from '@components/designer-project/ProjectDesigns'

const mapStateToProps = (state) => {
  const me = getMe(state)
  const designs = getMyDesigns(state)
  const winnerSpot = getCurrentProjectWinner(state)
  const winner = getDesignById(state, winnerSpot && winnerSpot.design)
  const mySpot = getMySpot(state)

  return {
    me,
    winner,
    mySpot,
    project: getCurrentProject(state),
    designs,
    inProgress: state.projects.inProgress,
  }
}

export default compose(
  connect(mapStateToProps, {
    reserveSpot,
    joinQueue,
    uploadDesign,
  }),
  withSpinner
)(ProjectDesigns)

