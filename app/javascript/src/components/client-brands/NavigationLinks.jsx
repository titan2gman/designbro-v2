import React from 'react'
import { Link, NavLink } from 'react-router-dom'

const NavigationLinks = ({ id }) => (
  <div className="links">
    <div className="navigation">
      <NavLink
        exact
        to={id ? `/c/brands/${id}/in-progress` : '/g'}
        activeClassName="active"
      >
        In progress
      </NavLink>

      <NavLink
        to={id ? `/c/brands/${id}/completed` : '/g/completed'}
        activeClassName="active"
      >
        Completed
      </NavLink>

      {false && (
        <NavLink
          to={`/c/brands/${id}/files`}
          activeClassName="active"
        >
          Files
        </NavLink>
      )}
    </div>

    {id && (
      <div className="new-project">
        <Link
          to={`/projects/new?brand_id=${id}`}
        >
          Start new project

          <span className="new-project-icon">
            +
          </span>
        </Link>
      </div>
    )}
  </div>
)

export default NavigationLinks
