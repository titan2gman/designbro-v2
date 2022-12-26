import partial from 'lodash/partial'

import { connect } from 'react-redux'
import { history } from '../../history'

import {
  rateDesign,
  selectWinner,
  blockDesigner,
  selectFinalist,
  eliminateDesign,
  approveStationery
} from '@actions/designs'

import { getDesignById } from '@reducers/designs'

import { showModal } from '@actions/modal'

import ClientProjectDesign from '@projects/components/ClientProjectDesign'

const mapStateToProps = (state, props) => ({
  design: getDesignById(state, props.spot && props.spot.design)
})

const mapDispatchToProps = {
  eliminateDesign,
  selectFinalist,
  selectWinner,
  approveStationery,
  blockDesigner,
  showModal,
  rateDesign,
}

const mergeProps = (stateProps, dispatchProps, ownProps) => {
  const { project, spot, finalists } = ownProps
  const { blockDesigner, showModal, selectFinalist, selectWinner, eliminateDesign } = dispatchProps
  const canSelectFinalists = project.state === 'design_stage' && project.projectType === 'contest'
  const canSelectWinner = spot && spot.state === 'finalist'
  const finalistsLeft = (canSelectFinalists && finalists) ? (project.maxCountOfFinalists - finalists.length) : 'Error'
  const onRateDesign = partial(dispatchProps.rateDesign, project.id)
  const onDesignClick = () => {
    const spotMenu = window.getComputedStyle(document.getElementById(`spot${spot.id}`), null).getPropertyValue('visibility')
    if (spotMenu === 'hidden') {
      ownProps.onDesignClick(spot)
    }
  }
  const onDropItemClick = () => {
    ownProps.onDesignClick(spot)
  }

  return {
    ...stateProps,
    ...dispatchProps,
    ...ownProps,
    canSelectWinner,
    canSelectFinalists,
    finalistsLeft,
    onDesignClick,
    onDropItemClick,
    onRateDesign,
    onEliminateDesign: (designId) => {
      showModal('ELIMINATE_WORK', {
        onConfirm: (eliminateData) => eliminateDesign(project.id, designId, eliminateData),
        project
      })
    },
    onBlockDesigner: (designId) => {
      showModal('BLOCK_DESIGNER', {
        onConfirm: (blockData) => blockDesigner(project.id, designId, blockData),
        design: stateProps.design,
        project
      })
    },
    onSelectFinalist: () => {
      if (spot) {
        showModal('CONFIRMATION_MODAL', {
          onConfirm: () => selectFinalist(project.id, spot.design),
          content: 'Select this Designer as finalist?'
        })
      }
    },
    onSelectWinner: () => {
      if (spot) {
        showModal('CONFIRMATION_MODAL', {
          onConfirm: () => selectWinner(spot.design),
          content: project.projectType === 'contest' ? 'Select this Designer as winner?' : 'Do you want to approve this design?'
        })
      }
    },
    projectId: spot ? spot.project : null,
    designId: spot ? spot.design : null
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps,
  mergeProps
)(ClientProjectDesign)
