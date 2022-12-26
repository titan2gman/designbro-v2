import React from 'react'
import PropTypes from 'prop-types'

import { DetailsItem } from '@components/ProjectCard'

const ProjectTime = ({ project, stats, hint, show, isBuyTimeVisible, showAdditionalTimeModal }) => (
  <div className="m-l-20">
    {show && (
      <li className="project-detail project-time">
        <i className="project-detail__icon icon icon-time" />
        <div>
          <div>
            <span className="project-detail__number">
              {stats}
            </span>

            <span className="project-detail__text">
              {hint}
            </span>
          </div>

          {isBuyTimeVisible && (
            <div className="buy-time-wrapper">
              <button onClick={(e) => { e.preventDefault(); e.stopPropagation(); showAdditionalTimeModal({ project }); return false }} className="buy-time">Buy time</button>
            </div>
          )}
        </div>
      </li>
    )}
  </div>
)

ProjectTime.propTypes = {
  stats: PropTypes.string.isRequired,
  hint: PropTypes.string.isRequired,
  show: PropTypes.bool.isRequired
}

export default ProjectTime
