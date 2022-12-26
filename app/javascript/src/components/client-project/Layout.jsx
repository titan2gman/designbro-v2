import React from 'react'
import { Switch, Route, NavLink } from 'react-router-dom'

import ProjectLayoutHeader from '../shared/ProjectLayoutHeader'

import BriefPage from '../../containers/client-project/Brief'
import DesignsPage from '../../containers/client-project/Designs'
import FilesPage from '../../views/ClientProjectFilesView'
import ProjectTitle from '../shared/ProjectTitle'

export default ({ brand, project, me }) => (
  <div className="page-main">
    <div className="main-subheader__content-flex flex">
      <ProjectTitle brandName={brand.name} productKey={project.productKey} />
    </div>
    
    <div className="dpj-subheader main-subheader">
      <ProjectLayoutHeader project={project} currentUser={me.userType}/>
    </div>

    <div className="dpj-content">
      <NavLink
        exact
        to={`/c/projects/${project.id}/brief`}
        className="dpj-tab__title main-body__title main-body__tab-title"
        activeClassName="main-body__tab-title--active"
      >
        Brief
        <span className="main-body__tab-line" />
      </NavLink>

      <NavLink
        exact
        to={`/c/projects/${project.id}`}
        className="dpj-tab__title main-body__title main-body__tab-title"
        activeClassName="main-body__tab-title--active"
      >
        Designs
        <span className="main-body__tab-line" />
      </NavLink>

      {project.winner && project.state !== 'stationery' && (
        <NavLink
          exact
          to={`/c/projects/${project.id}/files`}
          className="dpj-tab__title main-body__title main-body__tab-title"
          activeClassName="main-body__tab-title--active"
        >
          Files
          <span className="main-body__tab-line" />
        </NavLink>
      )}

      <Switch>
        <Route exact path="/c/projects/:id" component={DesignsPage} />
        <Route exact path="/c/projects/:id/brief" component={BriefPage} />
        <Route exact path="/c/projects/:id/files" component={FilesPage} />
      </Switch>
    </div>
  </div>
)
