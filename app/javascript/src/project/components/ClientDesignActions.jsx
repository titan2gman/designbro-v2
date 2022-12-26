import React from 'react'
import PropTypes from 'prop-types'
import { Link } from 'react-router-dom'

const ClientDesignActions = ({
  isUploaded,
  isFinalist,
  onBlockDesigner,
  canSelectWinner,
  onSelectFinalist,
  onSelectWinner,
  onEliminateDesign,
  canSelectFinalists,
  onApproveStationery,
  canApproveStationery,
  project,
  closeLink,
  onClose
}) => (
  <div className="client-actions__panel">
    <div className="client-actions__button-wrapper">
      {canSelectFinalists &&
        <button
          id="select-finalist"
          className="conv-actions__positive-btn"
          type="button"
          onClick={onSelectFinalist}
        >
          <i className="icon-check conv-actions__icon"/>
          Select as finalist
        </button>
      }

      {canApproveStationery &&
        <button
          id="approve-design"
          className="conv-actions__positive-btn"
          type="button"
          onClick={onApproveStationery}
        >
          <i className="icon-check conv-actions__icon" />
          Approve
        </button>
      }

      {isFinalist && canSelectWinner &&
        <button
          id="select-winner"
          className="conv-actions__positive-btn"
          type="button"
          onClick={onSelectWinner}
        >
          <i className="icon-check conv-actions__icon" />
          {project.projectType === 'contest' ? 'Select as winner' : 'Approve design & request files'}
        </button>
      }

      {isUploaded && (project.state === 'design_stage') && (project.projectType === 'contest') && (
        <>
          {project.eliminateDesignerAvailable && (
            <button
              id="eliminate-work"
              className="conv-actions__negative-btn"
              type="button"
              onClick={onEliminateDesign}
            >
              <i className="icon-trash conv-actions__icon" />
              Eliminate design
            </button>
          )}

          {project.blockDesignerAvailable && (
            <button
              id="block-designer"
              className="conv-actions__negative-btn"
              type="button"
              onClick={onBlockDesigner}
            >
              <i className="icon-cross conv-actions__icon" />
              Block Designer
            </button>
          )}
        </>
      )}
    </div>
    <div
      onClick={onClose}
      className="conv-actions__close-btn"
    >
    </div>
  </div>
)

ClientDesignActions.propTypes = {
  isBanned: PropTypes.bool.isRequired,
  isWinner: PropTypes.bool.isRequired,
  isFinalist: PropTypes.bool.isRequired,
  isUploaded: PropTypes.bool.isRequired,
  isEliminated: PropTypes.bool.isRequired,
  canSelectWinner: PropTypes.bool.isRequired,
  canSelectFinalists: PropTypes.bool.isRequired,
  canApproveStationery: PropTypes.bool.isRequired,

  onBlockDesigner: PropTypes.func.isRequired,
  onSelectFinalist: PropTypes.func.isRequired,
  onEliminateDesign: PropTypes.func.isRequired,
  onApproveStationery: PropTypes.func.isRequired,

  closeLink: PropTypes.string.isRequired,
}

export default ClientDesignActions
