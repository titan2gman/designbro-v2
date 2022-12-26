import React from 'react'
import { Router, Route, Switch, Redirect } from 'react-router-dom'
import { history } from './history'
import { products } from './constants'

import App from '@containers/App'

import ProjectBuilderInitialStepView from './views/ProjectBuilderInitialStepView'
import ProjectBuilderFirstStepView from './views/ProjectBuilderFirstStepView'
import ProjectBuilderStepView from './views/ProjectBuilderStepView'
import ProjectBuilderSuccessView from './views/ProjectBuilderSuccessView'

import ClientBrandsView from './views/ClientBrandsView'
import ClientProjectsInProgressView from './views/ClientProjectsInProgressView'
import ClientProjectsCompletedView from './views/ClientProjectsCompletedView'

import LoginView from './views/Login'
import SignupClientView from './views/SignupClient'
import SignupDesignerView from './views/SignupDesigner'
import SignupDesignerProfileStep from './views/SignupDesignerProfileStep'
import SignupDesignerPortfolioStep from './views/SignupDesignerPortfolioStep'
import SignupDesignerFinishStep from './views/SignupDesignerFinishStep'

import DesignerSettingsLayout from './views/DesignerSettingsLayout'

import DesignerDashboardView from './views/DesignerDashboardView'

import DesignerDashboardProjectsInProgressView from './views/DesignerDashboardProjectsInProgressView'
import DesignerDashboardProjectsCompletedView from './views/DesignerDashboardProjectsCompletedView'
import DesignerDashboardDiscoverView from './views/DesignerDashboardDiscoverView'

import DesignerDirectConversationView from './views/DesignerDirectConversationView'
import ClientDirectConversationView from './views/ClientDirectConversationView'

import DesignerProjectBriefView from './views/DesignerProjectBriefView'
import DesignerProjectFilesView from './views/DesignerProjectFilesView'
import DesignerProjectDesignsView from './views/DesignerProjectDesignsView'

import DesignerNdasView from './views/DesignerNdasView'
import DesignerMyEarningsView from './views/DesignerMyEarningsView'
import DesignerPayoutsView from './views/DesignerPayoutsView'
import DesignerDeliverablesView from './views/DesignerDeliverablesView'

import ClientProjectLayout from './views/ClientProjectLayout'
import ClientSettingsLayout from './views/ClientSettingsLayout'
import ClientTransactionsView from './views/ClientTransactionsView'

import SignupResendConfirmationView from './views/SignupResendConfirmationView'
import PasswordRestoreView from './views/PasswordRestoreView'
import PasswordRestoredView from './views/PasswordRestoredView'
import PasswordResetView from './views/PasswordResetView'

import MainView from './views/MainView'

import ErrorLayout from '@components/ErrorLayout'

import GodClientProjectsInProgressView from './views/GodClientProjectsInProgressView'
import GodClientProjectsCompletedView from './views/GodClientProjectsCompletedView'

import { Layout as NewProjectBuilderLayout } from './features/new-project-builder'

const Routes = () => (
  <Router history={history}>
    <App>
      <Switch>
        <Route path="/login" component={LoginView} />
        <Route path="/c/signup" component={SignupClientView} />

        <Route path="/d/signup" exact component={SignupDesignerView} />

        <Route path="/d/signup/profile" component={SignupDesignerProfileStep} />
        <Route path="/d/signup/portfolio" component={SignupDesignerPortfolioStep} />
        <Route path="/d/signup/finish" component={SignupDesignerFinishStep} />

        <Route exact path="/projects/new" component={ProjectBuilderInitialStepView} />
        <Route exact path={`/projects/new/:productKey(${products.join('|')})`} component={ProjectBuilderFirstStepView} />
        <Route exact path="/projects/:id/success" component={ProjectBuilderSuccessView} />
        <Route exact path="/projects/:id/:step" component={ProjectBuilderStepView} />

        <Route path="/new-project" component={NewProjectBuilderLayout} />

        <Route path="/c/brands/:id/in-progress" component={ClientProjectsInProgressView} />
        <Route path="/c/brands/:id/completed" component={ClientProjectsCompletedView} />

        <Route exact path="/c" component={ClientBrandsView} />

        <Route exact path="/d" component={DesignerDashboardView} />
        <Route exact path="/d/discover" component={DesignerDashboardDiscoverView} />
        <Route path="/d/discover/:product_category_id" component={DesignerDashboardDiscoverView} />

        <Route path="/d/in-progress" component={DesignerDashboardProjectsInProgressView} />
        <Route path="/d/completed" component={DesignerDashboardProjectsCompletedView} />

        <Route exact path="/g" component={GodClientProjectsInProgressView} />
        <Route path="/g/completed" component={GodClientProjectsCompletedView} />

        <Route exact path="/d/projects/:id" component={DesignerProjectBriefView} />
        <Route exact path="/d/projects/:id/designs" component={DesignerProjectDesignsView} />
        <Route path="/d/projects/:id/files" component={DesignerProjectFilesView} />

        <Route path="/d/ndas" component={DesignerNdasView} />
        <Route path="/d/my-earnings" component={DesignerMyEarningsView} />
        <Route path="/d/payouts" component={DesignerPayoutsView} />
        <Route path="/d/deliverables" component={DesignerDeliverablesView}/>

        { /* Brief, Designs and Files pages */ }
        { /* /c/projects/:id */ }
        { /* /c/projects/:id/designs */ }
        { /* /c/projects/:id/files */ }
        <Route path="/c/projects/:id" component={ClientProjectLayout} />

        { /* Client settings */ }
        { /* /c/settings */ }
        { /* /c/settings/payment */ }
        { /* /c/settings/notifications */ }
        { /* /c/settings/password */ }
        <Route path="/c/settings" component={ClientSettingsLayout} />

        <Route path="/c/transactions" component={ClientTransactionsView} />

        { /* Client settings */ }
        { /* /d/settings */ }
        { /* /d/settings/notifications */ }
        { /* /d/settings/password */ }
        <Route path="/d/settings" component={DesignerSettingsLayout} />

        <Route path="/confirmation" component={SignupResendConfirmationView} />
        <Route path="/restore-password" component={PasswordRestoreView} />
        <Route path="/password-restored" component={PasswordRestoredView} />
        <Route path="/change-password/:token" component={PasswordResetView} />

        <Route exact path="/" component={MainView} />

        <Route path="/" component={ErrorLayout} />
      </Switch>
    </App>
  </Router>
)

export default Routes
