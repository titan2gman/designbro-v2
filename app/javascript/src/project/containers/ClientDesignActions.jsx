import { connect } from 'react-redux'
import { showModal } from '@actions/modal'
import {
  selectWinner,
  eliminateDesign,
  blockDesigner
} from '@actions/designs'

import { getDesign } from '@reducers/designs'
import { getSpotById } from '@reducers/spots'
import { getMe } from '@reducers/me'
import { getProject } from '@reducers/projects'

import ClientDesignActions from '@project/components/ClientDesignActions'

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

const mapStateToProps = (state) => {
  const design = getDesign(state)
  const spot = getSpotById(state, design.spot)
  const project = getProject(state)
  const me = getMe(state)

  return {
    design,
    designId: design && design.id,
    isBanned: design && design.banned,
    isFinalist: design && design.finalist,
    isWinner: spot && spot.state === 'winner',
    isUploaded: spot && spot.state === 'design_uploaded',
    isEliminated: spot && spot.state === 'eliminated',
    canApproveStationery: spot && spot.state === 'stationery_uploaded',
    closeLink: userLink(me.userType, project)
  }
}

const mapDispatchToProps = {
  eliminateDesign,
  blockDesigner,
  showModal,
  selectWinner
}

const mergeProps = (stateProps, dispatchProps, ownProps) => {
  const { eliminateDesign, blockDesigner } = dispatchProps

  return {
    ...stateProps,
    ...dispatchProps,
    ...ownProps,
    onSelectWinner: () => dispatchProps.showModal('CONFIRMATION_MODAL', {
      onConfirm: ownProps.onSelectWinner,
      content: ownProps.project.projectType === 'contest' ? 'Select this Designer as winner?' : 'Do you want to approve this design?'
    }),
    onSelectFinalist: () => dispatchProps.showModal('CONFIRMATION_MODAL', {
      onConfirm: ownProps.onSelectFinalist,
      content: 'Select this Designer as finalist?'
    }),
    onBlockDesigner: () => dispatchProps.showModal('BLOCK_DESIGNER', {
      onConfirm: (blockData) => blockDesigner(ownProps.project.id, stateProps.designId, blockData),
      project: ownProps.project,
      design: stateProps.design
    }),
    onEliminateDesign: () => dispatchProps.showModal('ELIMINATE_WORK', {
      onConfirm: (eliminateData) => eliminateDesign(ownProps.project.id, stateProps.designId, eliminateData),
      project: ownProps.project
    }),
    canSelectFinalists: ownProps.canSelectFinalists && stateProps.isUploaded
  }
}

export default connect(mapStateToProps, mapDispatchToProps, mergeProps)(ClientDesignActions)
