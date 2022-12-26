import React from 'react'
import PropTypes from 'prop-types'
import { Modal } from 'semantic-ui-react'

import JoinQueueModalContent from '@modals/reserve-spot/containers/JoinQueueModalContent'
import ReserveSpotModalContent from '@modals/reserve-spot/containers/ReserveSpotModalContent'

const ReserveSpotModal = ({ hideModal, project, me }) => {
  const areSpotsUnavailable = me.maxActiveSpotsCount !== null && me.activeSpotsCount >= me.maxActiveSpotsCount

  return (
    <Modal open onClose={hideModal} className="main-modal" size="small">
      <div className="modal-primary">
        { areSpotsUnavailable ? (
          <div className="modal-primary__body-block modal-primary__block-p-b text-center">
            <p className="modal-primary__text">
              You've reached the maximum amount of active spots: {me.maxActiveSpotsCount} out of {me.maxActiveSpotsCount}.
            </p>
            <button onClick={hideModal} className="main-button main-button--clear-black main-button--md">Ok</button>
          </div>
        ) : (
          <>
            <div className="modal-primary__header bg-green-500 in-white">
              <p className="modal-primary__header-title">
                Reserve Spot
              </p>
            </div>

            {project.spotsAvailable > 0
              ? <ReserveSpotModalContent project={project}/>
              : <JoinQueueModalContent project={project}/>
            }
          </>
        )}
      </div>
    </Modal>
  )
}

ReserveSpotModal.propTypes = {
  hideModal: PropTypes.func.isRequired,
  project: PropTypes.object.isRequired,
  me: PropTypes.object.isRequired
}

export default ReserveSpotModal
