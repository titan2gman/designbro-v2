import { compose } from 'redux'
import { connect } from 'react-redux'
import React, { Component } from 'react'
import { NavLink, Switch, Route } from 'react-router-dom'

import { withDarkFooterLayout } from '../layouts'
import { requireDesignerAuthentication } from '../authentication'
import { loadProducts } from '@actions/products'
import { loadPortfolio } from '@actions/portfolio'

import PasswordChange from '@password/components/PasswordChange'
import GeneralDesignerSettings from '@components/Settings/GeneralDesigner'
import NotificationsSettings from '@components/Settings/Notifications'
import ExperienceSettings from '@components/Settings/Experience'
import PortfolioSettings from '@components/Settings/PortfolioSettings'

const hasData = (View) => {
  return class HasData extends Component {
    componentWillMount () {
      this.props.loadProducts()
      this.props.loadPortfolio()
    }

    render () {
      return <View {...this.props} />
    }
  }
}

const DesignerSettingsLayout = () => (
  <main className="settings__wrap">
    <div className="main-subheader">
      <div className="container">
        <h1 className="main-subheader__title">Account Settings</h1>
      </div>
    </div>
    <div className="settings__content container">
      <div className="settings__tabs-titles hidden-sm-down">
        <NavLink exact to="/d/settings" className="settings__tab-title main-body__title main-body__tab-title" activeClassName="main-body__tab-title--active">
          General
          <span className="main-body__tab-line" />
        </NavLink>
        <NavLink to="/d/settings/experience" className="settings__tab-title main-body__title main-body__tab-title" activeClassName="main-body__tab-title--active">
          Experience
          <span className="main-body__tab-line" />
        </NavLink>
        <NavLink to="/d/settings/notifications" className="settings__tab-title main-body__title main-body__tab-title" activeClassName="main-body__tab-title--active">
          Notifications
          <span className="main-body__tab-line" />
        </NavLink>
        <NavLink to="/d/settings/password" className="settings__tab-title main-body__title main-body__tab-title" activeClassName="main-body__tab-title--active">
          Password
          <span className="main-body__tab-line" />
        </NavLink>
        <NavLink to="/d/settings/portfolio" className="settings__tab-title main-body__title main-body__tab-title" activeClassName="main-body__tab-title--active">
          Portfolio Page
          <span className="main-body__tab-line" />
        </NavLink>
      </div>

      <Switch>
        <Route exact path="/d/settings" component={GeneralDesignerSettings} />
        <Route path="/d/settings/experience" component={ExperienceSettings} />
        <Route path="/d/settings/notifications" component={NotificationsSettings} />
        <Route path="/d/settings/password" component={PasswordChange} />
        <Route path="/d/settings/portfolio" component={PortfolioSettings} />
      </Switch>
    </div>
  </main>
)

export default compose(
  connect(null, {
    loadProducts,
    loadPortfolio
  }),
  hasData,
  withDarkFooterLayout,
  requireDesignerAuthentication
)(DesignerSettingsLayout)
