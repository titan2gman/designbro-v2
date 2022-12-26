import { connect } from 'react-redux'
import { compose } from 'redux'

import { showModal } from '@actions/modal'
import { upload, destroySourceFile } from '@actions/sourceFiles'

import { withSpinner } from '@components/withSpinner'

import { getCurrentProject } from '@selectors/projects'
import { getDesignById } from '@reducers/designs'
import { getCurrentProjectWinner } from '@reducers/spots'
import { getProjectById, getProjectLoaded } from '@reducers/projects'
import { getSourceFiles, getSourceFilesLoaded } from '@reducers/sourceFiles'

import ProjectFiles from '@components/designer-project/ProjectFiles'

const mapStateToProps = (state) => {
  const inProgress = state.projects.inProgress || state.sourceFiles.inProgress

  if (inProgress) {
    return {
      inProgress
    }
  }

  const project = getCurrentProject(state)
  const winnerSpot = getCurrentProjectWinner(state)
  const winnerDesign = getDesignById(state, winnerSpot && winnerSpot.design)
  const files = getSourceFiles(state)
  const authHeaders = state.authHeaders

  return {
    inProgress,
    project,
    files,
    winnerDesign,
    authHeaders
  }
}

export default compose(
  connect(mapStateToProps, {
    upload,
    destroySourceFile,
    showModal
  }),
  withSpinner
)(ProjectFiles)
