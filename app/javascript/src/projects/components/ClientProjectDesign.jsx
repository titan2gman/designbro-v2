import React from 'react'
import { Link } from 'react-router-dom'

import { normalizeState } from '@utils/spots'

import RatingStars from '@components/RatingStars'

const DesignerProjectFrameAction = ({ onClick, text }) => (
  <li className="preview-frame-menu__dropd-item">
    <a
      onClick={onClick}
      className="preview-frame-menu__dropd-item-link cursor-pointer"
    >
      {text}
    </a>
  </li>
)

const DesignerProjectFrameLink = ({ to, text }) => (
  <li className="preview-frame-menu__dropd-item">
    <Link to={to} className="preview-frame-menu__dropd-item-link cursor-pointer">
      {text}
    </Link>
  </li>
)

const DesignState = ({ state }) => {
  const processedState = normalizeState(state)

  if (processedState) {
    return (
      <span className="status-indicator in-white bg-black">
        {processedState}
      </span>
    )
  }

  return null
}

const UploadedSpot = ({
  spot,
  design,
  spotType,
  project,
  canSelectFinalists,
  canSelectWinner,
  onSelectFinalist,
  onSelectWinner,
  finalistsLeft,
  onEliminateDesign,
  onBlockDesigner,
  approveStationery,
  onDesignClick,
  onDropItemClick,
  onRateDesign,
}) => (
  <div className="preview-frame-block">
    <div
      className="preview-frame preview-frame__img bg-grey-100 cursor-pointer"
      style={{ backgroundImage: `url(${spot.uploadedFile.file.url})` }}
      onClick={onDesignClick}
    >
      <div className="preview-frame__content flex-end">
        <div className="preview-frame-menu">
          <i className="preview-frame-menu__icon icon-ellipsis" />
          <ul id={`spot${spot.id}`} className="preview-frame-menu__dropd">
            {spot.state === 'stationery_uploaded' && (
              <DesignerProjectFrameAction
                onClick={approveStationery.bind(null, project.id, spot.design)}
                text={
                  <span>
                    <i className="icon-check font-11 m-r-15" />
                    Approve
                  </span>
                }
              />
            )}

            {canSelectWinner && (
              <DesignerProjectFrameAction
                onClick={onSelectWinner}
                text={
                  <span>
                    <i className="icon-check font-11 m-r-15" />

                    {project.projectType === 'contest' ? 'Winner' : 'Approve design'}
                  </span>
                }
              />
            )}

            <DesignerProjectFrameAction
              onClick={onDropItemClick}
              text={
                <span>
                  <i className="icon-eye font-10 m-r-15" />
                  View
                </span>
              }
            />

            <DesignerProjectFrameAction
              onClick={onDropItemClick}
              text={
                <span>
                  <i className="icon-message m-r-15" />
                  Comment
                </span>
              }
            />

            {spotType === 'inProgress' && canSelectFinalists && <DesignerProjectFrameAction
              onClick={onSelectFinalist}
              text={
                <span className="select-finalist-btn">
                  <i className="icon-check font-11 m-r-15" />

                  Select Finalist ({finalistsLeft} left)
                </span>
              }
            />
            }

            {spotType === 'inProgress' && project.eliminateDesignerAvailable && project.projectType === 'contest' && <DesignerProjectFrameAction
              onClick={onEliminateDesign.bind(null, spot.design)}
              text={
                <span>
                  <i className="icon-trash m-r-15" />
                  Eliminate Work
                </span>
              }
            />
            }

            {spotType === 'inProgress' && project.blockDesignerAvailable && project.projectType === 'contest' && <DesignerProjectFrameAction
              onClick={onBlockDesigner.bind(null, spot.design)}
              text={
                <span>
                  <i className="icon-cross m-r-15 font-12" />
                  Block Designer
                </span>
              }
            />
            }
          </ul>
        </div>
      </div>
    </div>

    <SpotInfo spot={spot} projectType={project.projectType} />

    <div className="viewer-info text-center">
      <RatingStars value={design.rating} onClick={(value) => onRateDesign(spot.design, value)} />
    </div>
  </div>
)

const SpotInfo = ({ spot, projectType }) => (
  <div className="text-center">
    {projectType === 'contest' && <DesignState state={spot.state} />}

    <p className="dpj-content__uploaded-text">
      <span className="m-r-5">by</span>

      <a className="text-underline in-grey-300">
        {spot.designerName}
      </a>
    </p>
  </div>
)

const WaitingForDesignSpot = ({ spot }) => (
  <div className="preview-frame-block">
    <div className="preview-frame bg-grey-100">
      <div className="preview-frame__content align-center justify-center">
        <i className="icon-clock in-grey-200 font-40 m-b-15" />
        <p className="preview-frame__text font-bold">Waiting for design</p>
      </div>
    </div>
    <div className="text-center">
      <p className="dpj-content__uploaded-text">
        <span className="m-r-5">by</span>
        <a className="text-underline in-grey-300">
          {spot.designerName}
        </a>
      </p>
    </div>
  </div>
)

const EmptySpot = () => (
  <div className="preview-frame-block">
    <div className="preview-frame bg-grey-100">
      <div className="preview-frame__content align-center justify-center">
        <i className="icon-circle in-grey-200 font-40 m-b-15" />
        <p className="preview-frame__text font-bold">Vacant</p>
      </div>
    </div>
  </div>
)

const ClientProjectDesign = ({
  spot,
  index,
  design,
  project,
  spotType,
  onEliminateDesign,
  onSelectFinalist,
  onSelectWinner,
  selectWinner,
  canSelectFinalists,
  canSelectWinner,
  finalistsLeft,
  approveStationery,
  onBlockDesigner,
  onDesignClick,
  onRateDesign,
  projectId,
  designId,
  onDropItemClick
}) => (
  <div className="col-md-4 col-lg-3" id={`design-${spot && spot.design}`}>
    <p className="dpj-content__title">Spot {index + 1}</p>

    {spot && spot.uploadedFile && <UploadedSpot
      spot={spot}
      design={design}
      project={project}
      spotType={spotType}
      selectWinner={selectWinner}
      canSelectFinalists={canSelectFinalists}
      canSelectWinner={canSelectWinner}
      onSelectFinalist={onSelectFinalist}
      onSelectWinner={onSelectWinner}
      finalistsLeft={finalistsLeft}
      onEliminateDesign={onEliminateDesign}
      onBlockDesigner={onBlockDesigner}
      approveStationery={approveStationery}
      onDesignClick={onDesignClick}
      onRateDesign={onRateDesign}
      projectId={projectId}
      designId={designId}
      onDropItemClick={onDropItemClick}
    />}

    {spot && !spot.uploadedFile && <WaitingForDesignSpot spot={spot} />}

    {!spot && <EmptySpot />}

  </div>
)

export default ClientProjectDesign
