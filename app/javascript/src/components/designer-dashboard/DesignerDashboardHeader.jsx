import React from 'react'
import { Link } from 'react-router-dom'

const DesignerDashboardHeader = () => (
  <div>
    <Link className="designer-dashboard__tab-title main-body__title main-body__tab-title main-body__tab-title--active" to="/d">My Projects</Link>
    <Link className="designer-dashboard__tab-title main-body__title main-body__tab-title" to="/d/discover">Discover Projects</Link>
  </div>
)

export default DesignerDashboardHeader
