import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

import RestoreVersionButton from '@project/containers/RestoreVersionButton'
import DesignVersionsPreview from '@project/components/DesignVersionsPreview'

const PreviousVersionBtn = ({ onClick, className }) => (
  <button onClick={onClick} className={classNames('conv-actions__btn-darkgrey-negative', className)}>
    <i className="icon-time-ago-circle conv-actions__icon"/>
    Previous designs
  </button>
)

PreviousVersionBtn.propTypes = {
  className: PropTypes.string,
  onClick: PropTypes.func.isRequired
}

const HideVersionsBtn = ({ onClick }) => (
  <div onClick={onClick}>
    <i className="icon-arrow-down previous-versions-arrow-icon"/>
  </div>
)

HideVersionsBtn.propTypes = {
  onClick: PropTypes.func.isRequired
}

const DesignVersionsPanel = ({ selected, loading, versions, triggerVersionsPanel, onClick, onRestore, userType, onPreviousDesignHover }) => {
  useEffect(() => {
    const onClickHandler = e => {
      const designVersionsPanel = document.getElementsByClassName('design-versions__panel')[0]
      if (!designVersionsPanel.classList.contains('popover__hidden') && !designVersionsPanel.contains(e.target) && e.target.id !== 'restore-previous-versions-btn') {
        triggerVersionsPanel()
      }
    }
    document.addEventListener('click', onClickHandler)

    return () => {
      document.removeEventListener('click', onClickHandler)
    }
  }, [])

  return (
    <>
      <div className={onRestore ? 'previous-versions__action-container-1' : 'previous-versions__action-container'}>
        <div className="previous-versions__action">
          <PreviousVersionBtn onClick={triggerVersionsPanel}/>
          { onRestore ?
            <RestoreVersionButton onClick={onRestore} versionSelected={selected}/> : (
              <button className="icon-info-circle conv-actions__info-icon">
                <div className="previous-versions__info-icon-popover">
                  Please ask your designer in the chat to restore a previous design
                </div>
              </button>
            )}
        </div>
        <div>
          <HideVersionsBtn onClick={triggerVersionsPanel} />
        </div>
      </div>
      <DesignVersionsPreview loading={loading} selected={selected} versions={versions} onClick={onClick} userType={userType} onPreviousDesignHover={onPreviousDesignHover}/>
    </>
  )
}

DesignVersionsPanel.propTypes = {
  loading: PropTypes.bool.isRequired,
  versions: PropTypes.array.isRequired,
  selected: PropTypes.string.isRequired,

  onClick: PropTypes.func.isRequired,
  onRestore: PropTypes.func,
  triggerVersionsPanel: PropTypes.func.isRequired,
  userType: PropTypes.string.isRequired
}

export default DesignVersionsPanel
