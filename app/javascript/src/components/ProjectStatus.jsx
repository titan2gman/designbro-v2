import includes from 'lodash/includes'

import React from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

const getStatusColor = (projectState, suitableStates) => (
  includes(suitableStates, projectState)
    ? 'bg-green-500' : 'bg-grey-400'
)

const ProjectStatus = ({ type, state }) => (
  <div className="project-card__status-wrap">
    <div className="status-indicator-line">
      {['design_stage', 'finalist_stage', 'files_stage', 'review_files'].includes(state) && (
        <>
          <span
            className={classNames(
              'status-indicator-line__item',
              getStatusColor(state, type === 'contest' ? ['design_stage'] : ['design_stage', 'finalist_stage'])
            )}
          >
            Design
          </span>

          {type === 'contest' && <span className={classNames('status-indicator-line__item', getStatusColor(state, ['finalist_stage']))}>Finalist</span>}

          <span className={classNames('status-indicator-line__item', getStatusColor(state, ['files_stage', 'review_files']))}>Files</span>
        </>
      )}

      {state === 'draft' && (
        <span className={classNames('status-indicator-line__item', 'bg-grey-400')}>Not started</span>
      )}
    </div>
  </div>
)

ProjectStatus.propTypes = {
  type: PropTypes.string,
  state: PropTypes.string
}

export default ProjectStatus
