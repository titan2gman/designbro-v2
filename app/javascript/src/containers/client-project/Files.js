import { connect } from 'react-redux'
import { compose } from 'redux'
import { withSpinner } from '@components/withSpinner'

import { approveFiles } from '@actions/projects'
import { showModal, hideModal } from '@actions/modal'

import { getCurrentProject } from '@selectors/projects'
import { getMe } from '@reducers/me'
import { getCurrentProjectWinner } from '@reducers/spots'
import { getReviewByClientAndDesign } from '@reducers/reviews'
import { getDesignById } from '@reducers/designs'
import { getSourceFiles } from '@reducers/sourceFiles'

import Files from '@components/client-project/Files'

const mapStateToProps = (state) => {
  const inProgress = state.sourceFiles.inProgress || state.reviews.inProgress

  if (inProgress) {
    return {
      inProgress
    }
  }

  const project = getCurrentProject(state)
  const winnerSpot = getCurrentProjectWinner(state)
  const winnerDesign = getDesignById(state, winnerSpot.design)
  const review = getReviewByClientAndDesign(state, getMe(state).id, winnerDesign.id)
  const canLeaveReview = !review && project.state === 'completed'

  return {
    inProgress,
    project,
    winnerDesign,
    canLeaveReview,
    files: getSourceFiles(state),
    authHeaders: state.authHeaders,
    form: state.forms.review,

  }
}

export default compose(
  connect(mapStateToProps, {
    showModal,
    hideModal,
    approveFiles,
  }),
  withSpinner
)(Files)
