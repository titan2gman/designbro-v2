import React from 'react'
import PropTypes from 'prop-types'
import { Link } from 'react-router-dom'
import DesignerProjectCard from './DesignerProjectCard'

const DesignerProjectDiscoverText = () => (
  <div>
    You have no projects yet. <Link to="/d/discover" className="in-black text-underline">Discover</Link> new projects and join them.
  </div>
)

const MaterialBlankState = ({ canDiscoverProjects }) => {
  if (canDiscoverProjects) {
    return <BlankState src="/empty_page.png" text={<DesignerProjectDiscoverText />} />
  } else {
    return <BlankState src="/portfolio_not_approved_illustration_2Х.jpg" text="Your portfolio has not yet been approved" />
  }
}

const BlankState = ({ src, text }) => (
  <div className="col-xs-12 col-md-6 offset-md-3">
    <div className="blank-state">
      <img className="blank-state__img" src={src} srcSet={`${src} 2x`} alt="" />
      <div className="blank-state__text">
        {text}
      </div>
    </div>
  </div>
)

const DesignerDashboardContent = ({ projects, canDiscoverProjects, showModal, createDesignerNda }) => (
  <div>
    {projects.map((project, i) => (
      <DesignerProjectCard
        key={i}
        project={project}
        className="designer-dashboard__card"
        showModal={showModal}
        createDesignerNda={createDesignerNda}
      />
    ))}

    {!projects.length && <MaterialBlankState canDiscoverProjects={canDiscoverProjects} />}
  </div>
)

DesignerDashboardContent.propTypes = {
  projects: PropTypes.arrayOf(PropTypes.object).isRequired,
  canDiscoverProjects: PropTypes.bool.isRequired
}

export default DesignerDashboardContent
