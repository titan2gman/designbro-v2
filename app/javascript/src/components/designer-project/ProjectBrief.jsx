import _ from 'lodash'
import React, { Component } from 'react'
import PropTypes from 'prop-types'

import Layout from '../../containers/designer-project/Layout'
import ProjectBrief from '../shared/ProjectBrief'

const RESERVE_STATES = [
  'design_stage',
  'finalist_stage'
]

const stationerySpotStates = [
  'finalist',
  'stationery',
  'stationery_uploaded',
  'winner'
]

class DesignerProjectBrief extends Component {

  handleDesignTabClick = () => {
    const { showModal, project } = this.props

    showModal('RESERVE_SPOT', { project })
  }

  render() {

    const {
      additionalDocuments,
      badExamples,
      colorsExist,
      competitors,
      existingLogos,
      goodExamples,
      inspirations,
      project,
      product,
      brand,
      brandDna,
      spots,
      stockImages,
      newExamples
    } = this.props

    const areSpotStatesIntersecting = !_.isEmpty(_.intersection(_.map(spots, (spot) => spot.state), stationerySpotStates))

    return (
      <Layout
        page="brief"
      >
        <ProjectBrief
          project={project}
          product={product}
          brand={brand}
          brandDna={brandDna}
          goodExamples={goodExamples}
          badExamples={badExamples}
          competitors={competitors}
          colorsExist={colorsExist}
          inspirations={inspirations}
          existingLogos={existingLogos}
          additionalDocuments={additionalDocuments}
          stockImages={stockImages}
          spots={spots}
          areSpotStatesIntersecting={areSpotStatesIntersecting}
          newExamples={newExamples}
        >
          <div className="brief-section text-center">
            {RESERVE_STATES.includes(project.state) && project.canBeReserved && project.projectType === 'contest' && <span>
              <a className="in-black inline-block m-b-10 cursor-pointer" onClick={this.handleDesignTabClick}
              >
                <span className="font-bold">Reserve Spot</span>
                <i className="icon-arrow-right-circle m-l-10 align-middle font-40"/>
              </a>

              {project.spotsAvailable > 0 && <p className="brief-section__text-hint font-13 in-green-500">
                only {project.spotsAvailable} spots left!
              </p>}
            </span>}
          </div>
        </ProjectBrief>
      </Layout>
    )
  }
}

DesignerProjectBrief.propTypes = {
  handleDesignTabClick: PropTypes.func.isRequired,
  reserveSpot: PropTypes.func.isRequired,
  joinQueue: PropTypes.func.isRequired,

  additionalDocuments: PropTypes.arrayOf(PropTypes.object).isRequired,
  existingLogos: PropTypes.arrayOf(PropTypes.object).isRequired,
  goodExamples: PropTypes.arrayOf(PropTypes.object).isRequired,
  inspirations: PropTypes.arrayOf(PropTypes.object).isRequired,
  badExamples: PropTypes.arrayOf(PropTypes.object).isRequired,
  competitors: PropTypes.arrayOf(PropTypes.object).isRequired,

  channelParams: PropTypes.object.isRequired,
  reserveSpotModalOpen: PropTypes.string,
  spot: PropTypes.object.isRequired,
  me: PropTypes.object.isRequired,
  showStationery: PropTypes.bool,
  colorsExist: PropTypes.bool,
  project: PropTypes.object
}

export default DesignerProjectBrief
