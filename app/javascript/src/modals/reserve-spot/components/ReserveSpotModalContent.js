import React, { useState } from 'react'
import PropTypes from 'prop-types'

const spotExpiresTime = (reservationExpireDays) => {
  const dayHours = 24
  return reservationExpireDays * dayHours
}

const spotsStatistics = ({ maxSpotsCount, spotsAvailable: spotsAvailableCount }) => (
  `${maxSpotsCount - spotsAvailableCount}/${maxSpotsCount}`
)

const ReserveSpotModalContent = ({ project, handleReserve, hideModal }) => {
  const [submitting, setSubmitting] = useState(false)

  const handleMyReserve = () => {
    setSubmitting(true)
    handleReserve()
  }

  return (
    <div>
      <div className="modal-primary__body">
        <div className="brief-modal__body-block modal-primary__body-block">
          <ul className="project-details m-b-0">
            <li className="project-detail">
              <i className="project-detail__icon icon-person"/>
              <span className="project-detail__number">
                {spotsStatistics(project)}
              </span>

              <span className="project-detail__text">
                Spots
              </span>
            </li>

            <li className="project-detail">
              <i className="project-detail__icon icon-time font-17"/>

              <span className="project-detail__text">
                Spot expires in {spotExpiresTime(project.reservationExpireDays)} hours
              </span>
            </li>
          </ul>
        </div>
      </div>

      <div className="modal-primary__actions">
        <button type="button" onClick={hideModal} className="main-button-link main-button-link--lg in-grey-200 m-b-10">
          Cancel
        </button>

        <button type="button" onClick={handleMyReserve} disabled={submitting} className="main-button-link main-button-link--lg m-b-10">

          Reserve your spot

          <i className="m-l-20 font-8 icon-arrow-right-long in-green-500"/>
        </button>
      </div>
    </div>
  )
}

ReserveSpotModalContent.propTypes = {
  project: PropTypes.shape({
    maxSpotsCount: PropTypes.number.isRequired,
    spotsAvailable: PropTypes.number.isRequired
  }),

  hideModal: PropTypes.func.isRequired,
  handleReserve: PropTypes.func.isRequired
}

export default ReserveSpotModalContent
