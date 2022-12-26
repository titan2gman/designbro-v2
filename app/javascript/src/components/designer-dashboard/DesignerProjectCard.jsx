import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { withRouter } from 'react-router-dom'
import classNames from 'classnames'
import { humanizeProjectTypeName } from '@utils/humanizer'

import {
  Activity,
  Content,
  Description,
  DetailsGroup,
  DetailsItem,
  Footer,
  Icon,
  InfoButton,
  NdaIcon,
  Price,
  ProjectTime,
  Sidebar,
  Status,
  Title
} from '../ProjectCard'

class DesignerProjectCard extends Component {
  handleAcceptNda = () => {
    const { showModal, createDesignerNda, project, history } = this.props
    const projectPath = project.designs.length > 0 ? `/d/projects/${project.id}/designs` : `/d/projects/${project.id}`

    if (!project.nda || project.ndaType === 'free' || project.ndaAccepted) {
      history.push(projectPath)
    } else {
      showModal('AGREE_NDA', {
        onConfirm: () => {
          createDesignerNda(project).then((response) => {
            if (!response.error) {
              history.push(projectPath)
            }
          })
        },
        value: project.nda.value
      })
    }
  }

  render () {
    const { project, className } = this.props

    return (
      <div className={classNames('project-card cursor-pointer', className)} onClick={this.handleAcceptNda} >
        <Sidebar>
          <Icon type={project.productKey} />
          <Price price={project.winnerPrize} />
        </Sidebar>
        <Content>
          <Title name={project.name} />

          {project.ndaType !== 'free' &&
            <NdaIcon />
          }

          <div className="flex flex-wrap">
            <Status state={project.state} type={project.projectType} />
            <ProjectTime project={project} />
          </div>

          {!project.lastActivity &&
            <Content>
              <Description>
                {project.description}
              </Description>
            </Content>
          }

          {project.lastActivity && <Activity>
            {project.lastActivity.message}
          </Activity>}

          <Footer>
            <DetailsGroup>
              <DetailsItem icon="icon-person" stats={`${project.maxSpotsCount - project.spotsAvailable}/${project.maxSpotsCount}`} hint="Spots" />
              <DetailsItem icon="icon-landscape" stats={`${project.designsCount}/${project.maxSpotsCount}`} hint="Designs" />
            </DetailsGroup>

            <InfoButton onClick={this.handleAcceptNda} text="See Project" />
          </Footer>
        </Content>
      </div>
    )
  }
}

DesignerProjectCard.propTypes = {
  project: PropTypes.shape({
    price: PropTypes.number.isRequired,
    name: PropTypes.string.isRequired,
    state: PropTypes.string.isRequired,
    designers: PropTypes.number.isRequired,
    designs: PropTypes.array,
    finishAt: PropTypes.string
  }).isRequired,
  className: PropTypes.string,
  showModal: PropTypes.func.isRequired,
  history: PropTypes.shape({}).isRequired,
  createDesignerNda: PropTypes.func.isRequired,
}

export default withRouter(DesignerProjectCard)
