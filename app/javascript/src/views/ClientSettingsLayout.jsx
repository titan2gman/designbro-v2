import { compose } from 'redux'
import React from 'react'
import { NavLink, Switch, Route } from 'react-router-dom'

import PasswordChange from '../password/components/PasswordChange'
import GeneralClientSettings from '@components/Settings/GeneralClient'
import NotificationsSettings from '@components/Settings/Notifications'
import PaymentSettings from '@components/Settings/Payment'

import { withDarkFooterLayout } from '../layouts'
import { requireClientAuthentication } from '../authentication'

const Layout = () => (
  <main className="settings__wrap">
    <div className="main-subheader">
      <div className="container">
        <h1 className="main-subheader__title">Account Settings</h1>
      </div>
    </div>
    <div className="settings__content container">
      <div className="settings__tabs-titles hidden-sm-down">
        <NavLink exact to="/c/settings" className="settings__tab-title main-body__title main-body__tab-title" activeClassName="main-body__tab-title--active">
          General
          <span className="main-body__tab-line" />
        </NavLink>

        <NavLink to="/c/settings/payment" className="settings__tab-title main-body__title main-body__tab-title" activeClassName="main-body__tab-title--active">
          Payment
          <span className="main-body__tab-line" />
        </NavLink>

        <NavLink to="/c/settings/notifications" className="settings__tab-title main-body__title main-body__tab-title" activeClassName="main-body__tab-title--active">
          Notifications
          <span className="main-body__tab-line" />
        </NavLink>

        <NavLink to="/c/settings/password" className="settings__tab-title main-body__title main-body__tab-title" activeClassName="main-body__tab-title--active">
          Password
          <span className="main-body__tab-line" />
        </NavLink>
      </div>

      <Switch>
        <Route exact path="/c/settings" component={GeneralClientSettings} />
        <Route path="/c/settings/payment" component={PaymentSettings} />
        <Route path="/c/settings/notifications" component={NotificationsSettings} />
        <Route path="/c/settings/password" component={PasswordChange} />
      </Switch>
    </div>
  </main>
)

export default compose(
  withDarkFooterLayout,
  requireClientAuthentication
)(Layout)
