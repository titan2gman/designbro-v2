import { connect } from 'react-redux'
import { compose } from 'redux'
import { actions } from 'react-redux-form'

import { showModal } from '@actions/modal'
import { restoreVersion, uploadVersion } from '@actions/designVersions'
import { cleanDirectConversationMessages, sendMessage } from '@actions/directConversation'

import {
  getDesign,
  getViewMode,
  getShowChat,
  getDesignUploaded
} from '@reducers/designs'
import { getSpotById } from '@reducers/spots'
import {
  getProjectById,
  getProject
} from '@reducers/projects'
import { getMe } from '@reducers/me'

import Conversation from '@components/designer-project/Conversation'
import { withSpinner } from '@components/withSpinner'

const userLink = (userType, project) => {
  switch (userType) {
  case 'designer':
    return project.state === 'stationery' ? `/d/projects/${project.id}` : `/d/projects/${project.id}/designs`
  case 'client':
    return `/c/projects/${project.id}`
  default:
    return null
  }
}

const mapStateToProps = (state, ownProps) => {
  const inProgress = state.designs.inProgress || state.projects.inProgress

  if (inProgress) {
    return {
      inProgress
    }
  }

  const design = getDesign(state)
  const project = getProjectById(state, ownProps.projectId)
  const spot = getSpotById(state, design && design.spot)
  const currentProject = getProject(state)
  const me = getMe(state)

  return {
    spot,
    design,
    project,

    showChat: getShowChat(state),
    viewMode: getViewMode(state),
    inProgress,
    uploading: !getDesignUploaded(state),
    closeLink: userLink(me.userType, currentProject),
    user: me
  }
}

export default compose(
  connect(mapStateToProps, {
    sendMessage,
    restoreVersion,
    uploadVersion,
    showModal,
    cleanDirectConversationMessages,
    reset: () => actions.reset('forms.directConversation')
  }),
  withSpinner
)(Conversation)
