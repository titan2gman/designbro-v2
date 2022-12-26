import React from 'react'
import { Switch, Route } from 'react-router-dom'

import CreateNewProjectPage from './pages/CreateNewProjectPage'
import NewProjectStepPage from './pages/NewProjectStepPage'
import SuccessStepPage from './pages/SuccessStepPage'

const Routes = () => (
  <Switch>
    <Route exact path={'/new-project/:productKey(logo2)'} component={CreateNewProjectPage} />
    <Route exact path="/new-project/:projectId/success" component={SuccessStepPage} />
    <Route exact path="/new-project/:projectId/:step" component={NewProjectStepPage} />
  </Switch>
)

export default Routes
