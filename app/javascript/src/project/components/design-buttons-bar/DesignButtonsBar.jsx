import React from 'react'
import PropTypes from 'prop-types'

import PreviousVersionsBtn from '@project/containers/PreviousVersionsBtn'

const UploadedFilesBtn = ({ spot, onShowModal }) => (
  <span>
    {spot && spot.state === 'winner' &&
      <div onClick={onShowModal} className="conv-actions__btn-darkgrey-positive" style={{ marginRight: '0' }}>
        Upload files
      </div>
    }
  </span>
)

UploadedFilesBtn.propTypes = {
  spot: PropTypes.object,
  onShowModal: PropTypes.func.isRequired
}

const DesignButtonsBar = ({
  spot,
  onShowModal,
  triggerVersionsPanel
}) => (
  <>
    <div className="conv-bottom__buttons-bar-left">
      <div style={{ display: 'flex', justifyContent: 'center' }}>
        <PreviousVersionsBtn onClick={triggerVersionsPanel} />
      </div>
    </div>
    <div className="conv-bottom__buttons-bar-right">
      <div style={{ display: 'flex', justifyContent: 'center' }}>
        <UploadedFilesBtn spot={spot} onShowModal={onShowModal} />
      </div>
    </div>
  </>
)

DesignButtonsBar.propTypes = {
  spot: PropTypes.object,
  onShowModal: PropTypes.func.isRequired,
  onUploadDesign: PropTypes.func.isRequired,
  triggerVersionsPanel: PropTypes.func.isRequired
}

export default DesignButtonsBar
