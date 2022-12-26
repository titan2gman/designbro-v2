import { getStateTime } from '@utils/dateTime'
import React from 'react'
import PropTypes from 'prop-types'

const spotsStatistics = ({ maxSpotsCount, spotsAvailable: spotsAvailableCount }) => (
  `${maxSpotsCount - spotsAvailableCount}/${maxSpotsCount}`
)

const JoinQueueModalContent = ({ project, handleJoinQueue, hideModal }) => (
  <div>
    <div className="modal-primary__body">
      <div className="brief-modal__body-block modal-primary__body-block">
        <ul className="project-details m-b-20">
          <li className="project-detail">
            <i className="project-detail__icon icon-person" />

            <span className="project-detail__number">
              {spotsStatistics(project)}
            </span>

            <span className="project-detail__text">
              Spots
            </span>
          </li>

          <li className="project-detail">
            <i className="project-detail__icon icon-time font-17" />

            <span className="project-detail__number">
              {getStateTime(project)}
            </span>

            <span className="project-detail__text">
              Days left
            </span>
          </li>
        </ul>

        <p className="in-green-500">
          All spots are filled now
        </p>

        <p className="brief-modal__body-text in-grey-400">
          You can join a queue to wait for an available spot. There are&nbsp;

          {project.designersInQueueCount === 1 && <span>
            1 designer in the queue before you
          </span>}

          {project.designersInQueueCount !== 1 && <span>
            {project.designersInQueueCount} designers in the queue before you
          </span>}
        </p>
      </div>
    </div>

    <div className="modal-primary__actions">
      <button type="button" onClick={hideModal} className="main-button-link main-button-link--lg in-grey-200 m-b-10">
        Cancel
      </button>

      <button type="button" onClick={handleJoinQueue} className="main-button-link main-button-link--lg m-b-10">
        Join a queue

        <i className="m-l-20 font-8 icon-arrow-right-long in-green-500" />
      </button>
    </div>
  </div>
)

JoinQueueModalContent.propTypes = {
  project: PropTypes.shape({
    finishAt: PropTypes.string.isRequired,
    maxSpotsCount: PropTypes.number.isRequired,
    spotsAvailable: PropTypes.number.isRequired,
    designersInQueueCount: PropTypes.number.isRequired
  }),

  hideModal: PropTypes.func.isRequired,
  handleJoinQueue: PropTypes.func.isRequired
}

export default JoinQueueModalContent
