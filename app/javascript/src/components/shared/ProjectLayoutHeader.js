import React from 'react'
import { Status, ProjectTime } from '../ProjectCard'

export default ({ project, children, currentUser }) => (
  <div className="dpj-subheader__content">
    <Status state={project.state} type={project.projectType} />

    <div className="flex space-between">
      <ProjectTime project={project} />
      <ul className="dpj-subheader__details ">

        {currentUser !== 'client' && (
          <li className="project-detail">
            <i className="project-detail__icon icon-person" />
            <div className="project-detail__number">
              {project.maxSpotsCount - project.spotsAvailable}/{project.maxSpotsCount}
              <span className="main-subheader main-subheader__info-icon">
                Spots
              </span>
            </div>
          </li>
        )}

        <li className="project-detail">
          <i className="project-detail__icon icon-landscape" />
          <div className="project-detail__number">
            {project.designsCount}/{project.maxSpotsCount}
            <span className="main-subheader main-subheader__info-icon">
              Designs
            </span>
          </div>
        </li>
      </ul>
    </div>

    { children }
  </div>
)
