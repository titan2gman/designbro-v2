import _ from 'lodash'
import React, { Component, Fragment } from 'react'
import { NavLink, withRouter } from 'react-router-dom'

import ProjectLayoutHeader from '../shared/ProjectLayoutHeader'
import ReserveSpotModalTrigger from '@modals/reserve-spot/containers/ReserveSpotModalTrigger'
import UploadButton from '@components/inputs/UploadButton'
import ProjectTitle from '../shared/ProjectTitle'

const RESERVE_STATES = [
  'design_stage',
  'finalist_stage'
]

class DesignerProjectLayout extends Component {
  handleDesignTabClick = () => {
    const { project, showModal } = this.props

    showModal('RESERVE_SPOT', { project })
  }

  render () {
    const { me, page, project, brand, designs, mySpot, children, handleUpload } = this.props

    return (
      <Fragment>
        <div className="dpj-subheader main-subheader">
          <div className="container">
            <div className="main-subheader__content-flex flex">
              <ProjectTitle brandName={brand.name} productKey={project.productKey} />

              <div className="dpj-subheader__info-block">
                <span className="main-subheader__info-title hidden-md-down m-b-5">Prize</span>
                <p className="dpj-subheader__info-value main-subheader__info-value in-green-500 no-wrap">
                  $ {project.winnerPrize}
                </p>
              </div>
            </div>

            <ProjectLayoutHeader brand={brand} project={project} >
              {page === 'brief' && RESERVE_STATES.includes(project.state) && project.canBeReserved && (
                <ReserveSpotModalTrigger
                  containerClassName="m-b-10"
                  textClassName="font-bold"
                  project={project}
                />
              )}

              {page === 'designs' && project.state === 'design_stage' && _.isEmpty(designs) && (
                <div className="in-black m-b-10">
                  {mySpot.state !== 'expired' &&
                  <UploadButton onUpload={handleUpload}>
                    <span className="font-bold cursor-pointer">
                      Submit Design
                    </span>

                    <i className="icon-arrow-right-circle m-l-10 align-middle font-40" />
                  </UploadButton>
                  }
                </div>
              )}

              {page === 'files' && (
                <a href="#" className="cursor--not-allowed in-grey-200 m-b-10">
                  <span className="font-bold">Submit Design</span>
                  <i className="icon-arrow-right-circle m-l-10 align-middle font-40" />
                </a>
              )}
            </ProjectLayoutHeader >
          </div>
        </div>

        <div className="dpj-content container">
          <NavLink
            exact
            to={`/d/projects/${project.id}`}
            className="dpj-tab__title main-body__title main-body__tab-title"
            activeClassName="main-body__tab-title--active"
          >
            Brief
            <span className="main-body__tab-line" />
          </NavLink>

          {project.mySpotsCount > 0 && (
            <NavLink
              to={`/d/projects/${project.id}/designs`}
              className="dpj-tab__title main-body__title main-body__tab-title"
              activeClassName="main-body__tab-title--active"
            >
              Design
              <span className="main-body__tab-line" />
            </NavLink>
          )}

          {page === 'brief' && project.mySpotsCount === 0 && RESERVE_STATES.includes(project.state) && project.canBeReserved && <div
            className="dpj-tab__title main-body__title main-body__tab-title"
            onClick={this.handleDesignTabClick}
          >
            Design
          </div>}

          {project.winner === me.id && project.state !== 'stationery' && (
            <NavLink
              to={`/d/projects/${project.id}/files`}
              className="dpj-tab__title main-body__title main-body__tab-title"
              activeClassName="main-body__tab-title--active"
            >
              Files
              <span className="main-body__tab-line" />
            </NavLink>
          )}

          {children}
        </div>
      </Fragment>
    )
  }
}

export default withRouter(DesignerProjectLayout)
