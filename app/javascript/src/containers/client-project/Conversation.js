import { compose } from 'redux'
import { connect } from 'react-redux'
import { actions } from 'react-redux-form'
import includes from 'lodash/includes'

import { withSpinner } from '@components/withSpinner'

import Conversation from '@components/client-project/Conversation'

import {
  sendMessage,
  cleanDirectConversationMessages
} from '@actions/directConversation'

import {
  rateDesign,
  blockDesigner,
  selectFinalist,
  selectWinner,
  eliminateDesign,
  approveStationery
} from '@actions/designs'

import { getProjectById, getProjectLoaded } from '@reducers/projects'
import { getMe } from '@reducers/me'
import { getDesignLoaded, getViewMode, getShowChat, isCurrentDesignExists } from '@reducers/designs'

const mapStateToProps = (state, ownProps) => {
  const project = getProjectById(state, ownProps.projectId)

  const canSelectFinalists = project && project.state === 'design_stage' && project.projectType === 'contest'
  const canSelectWinner = project && includes(['finalist_stage', 'design_stage'], project.state)

  return {
    project,
    viewMode: getViewMode(state),
    showChat: getShowChat(state),
    inProgress: state.designs.inProgress || state.projects.inProgress || !isCurrentDesignExists(state),
    canSelectFinalists,
    canSelectWinner
  }
}

export default compose(
  connect(mapStateToProps, {
    rateDesign,
    sendMessage,
    blockDesigner,
    selectFinalist,
    selectWinner,
    eliminateDesign,
    approveStationery,
    cleanDirectConversationMessages,
    reset: () => actions.reset('forms.directConversation'),
  }),
  withSpinner,
)(Conversation)
