import React from 'react'
import PropTypes from 'prop-types'
import { Link } from 'react-router-dom'
import classNames from 'classnames'
import { getProjectBuilderPath } from '@utils/projectFinishPathHelper'
import {
  isPaymentNeeded,
  isInProgress,
  isCompleted,
  isBriefingNeeded,
  getProjectStateGroup
} from '@utils/projectStates'

import {
  Activity,
  Content,
  Description,
  DetailsGroup,
  DetailsItem,
  Footer,
  Icon,
  InfoLink,
  Price,
  ProjectTime,
  Sidebar,
  Status,
  Title
} from '../ProjectCard'

const DesignerProjectFrameAction = ({ to, onClick, text }) => (
  <li className="project-preview-frame-menu__dropd-item">
    {to ? (
      <Link
        to={to}
        className="project-preview-frame-menu__dropd-item-link cursor-pointer"
      >
        {text}
      </Link>
    ) : (
      <a
        onClick={onClick}
        className="project-preview-frame-menu__dropd-item-link cursor-pointer"
      >
        {text}
      </a>
    )}
  </li>
)

const ContextMenu = ({ project, deleteProject }) => (
  <div className="project-preview-frame-menu">
    <i className="project-preview-frame-menu__icon icon-ellipsis"/>
    <ul className="project-preview-frame-menu__dropd">
      <DesignerProjectFrameAction
        to={getProjectBuilderPath(project)}
        text={
          <span>
            Finalize
            <i className="icon-check font-14 m-l-15"/>
          </span>
        }
      />

      <DesignerProjectFrameAction
        onClick={(e) => {
          e.preventDefault()
          deleteProject(project.id)
        }}
        text={
          <span>
            Delete draft
            <i className="icon-cross font-14 m-l-15"/>
          </span>
        }
      />
    </ul>
  </div>
)

const getProjectCardRoute = (project) => {
  if (isInProgress(project) || isCompleted(project)) {
    return {
      to: `/c/projects/${project.id}`,
      text: 'See Project'
    }
  }

  if (isBriefingNeeded(project)) {
    return {
      to: `${getProjectBuilderPath(project)}`,
      text: 'Complete briefing'
    }
  }

  if (isPaymentNeeded(project)) {
    return {
      to: `${getProjectBuilderPath(project)}`,
      text: 'Finalize'
    }
  }
}

const ProjectCard = ({ project, deleteProject }) => {
  const linkProps = getProjectCardRoute(project)

  return (
    <Link to={linkProps.to}>
      <div className={classNames('project-card project-preview-frame', project.state)}>
        <Sidebar>
          <Icon type={project.productKey}/>

          {!!project.price && (
            <Price price={project.price}/>
          )}
        </Sidebar>

        <Content>
          <Title name={project.name}/>

          <div className="flex flex-wrap">
            <Status state={project.state} type={project.projectType} />
            <ProjectTime project={project}/>
          </div>

          {project.lastActivity && (
            <Activity>
              {project.lastActivity.message}
            </Activity>
          )}

          {!project.lastActivity && project.description && (
            <Description>
              {project.description}
            </Description>
          )}

          {!project.lastActivity && !project.description && isPaymentNeeded(project) && (
            <Description>
              {getProjectStateGroup(project)}
            </Description>
          )}

          <Footer>
            <DetailsGroup>
              <DetailsItem icon="icon-person" stats={`${project.maxSpotsCount - project.spotsAvailable}/${project.maxSpotsCount}`} hint="Spots"/>
              <DetailsItem icon="icon-landscape" stats={`${project.designsCount}/${project.maxSpotsCount}`} hint="Designs"/>
            </DetailsGroup>

            <InfoLink {...linkProps} />
          </Footer>
        </Content>

        {isPaymentNeeded(project) && (
          <ContextMenu
            project={project}
            deleteProject={deleteProject}
          />
        )}
      </div>
    </Link>
  )
}

ProjectCard.propTypes = {
  handleCardClick: PropTypes.func.isRequired,

  project: PropTypes.shape({
    productKey: PropTypes.oneOf([
      'brand-identity',
      'packaging',
      'logo'
    ]),
    id: PropTypes.string.isRequired,
    name: PropTypes.string.isRequired,
    state: PropTypes.string.isRequired,
    price: PropTypes.number.isRequired,
    finishAt: PropTypes.string.isRequired,
    designers: PropTypes.number.isRequired,
    designs: PropTypes.arrayOf(PropTypes.object)
  }).isRequired,

  className: PropTypes.string
}

export default ProjectCard
