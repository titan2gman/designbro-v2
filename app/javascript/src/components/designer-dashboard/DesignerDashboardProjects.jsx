import React from 'react'
import PropTypes from 'prop-types'
import DesignerStatsPanel from '@designer/containers/DesignerStatsPanel'
import DesignerDashboardFilters from './DesignerDashboardFilters'
import DesignerDashboardHeader from './DesignerDashboardHeader'
import DesignerDashboardContent from './DesignerDashboardContent'

const DesignerDashboardProjects = ({ projects, canDiscoverProjects, showModal, createDesignerNda }) => (
  <div className="designer-dashboard">
    <div className="flex-grow">
      <div className="container">
        <div className="designer-dashboard__content">
          <div className="row">
            <div className="col-xs-12">
              <DesignerDashboardHeader />
              <DesignerDashboardFilters />
            </div>
          </div>
          <div className="flex-grow">
            <div className="container">
              <div className="row">
                <div className="designer-dashboard__content col-xs-12">
                  <DesignerDashboardContent
                    projects={projects}
                    canDiscoverProjects={canDiscoverProjects}
                    showModal={showModal}
                    createDesignerNda={createDesignerNda}
                  />
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <DesignerStatsPanel />
  </div>
)

DesignerDashboardProjects.propTypes = {
  projects: PropTypes.arrayOf(PropTypes.object),
  canDiscoverProjects: PropTypes.bool.isRequired
}

export default DesignerDashboardProjects
