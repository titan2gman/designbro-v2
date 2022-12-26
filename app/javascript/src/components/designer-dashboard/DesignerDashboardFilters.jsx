import React from 'react'
import { Link, NavLink } from 'react-router-dom'

import { appendKey } from '@utils/dropdowns'

import NavigationDropdown from '@containers/NavigationDropdown'

const filterOptions = [
  { text: 'In Progress', value: '/d/in-progress', as: Link, to: '/d/in-progress' },
  { text: 'Completed', value: '/d/completed', as: Link, to: '/d/completed' }
].map(appendKey)

const DesignerDashboardFilters = () => (
  <div className="designer-dashboard__filters">
    <NavigationDropdown className="designer-dashboard__filters-dropdown main-dropdown main-dropdown-sm hidden-md-up" fluid selection options={filterOptions} />

    <div className="hidden-sm-down">
      <NavLink to="/d/in-progress" className="designer-dashboard__filter content-filter" activeClassName="content-filter--active">In Progress</NavLink>
      <NavLink to="/d/completed" className="designer-dashboard__filter content-filter" activeClassName="content-filter--active">Completed</NavLink>
    </div>
  </div>
)

export default DesignerDashboardFilters
