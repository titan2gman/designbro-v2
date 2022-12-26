import React from 'react'
import ReactDOM from 'react-dom'
import { Provider } from 'react-redux'
import { StripeProvider } from 'react-stripe-elements'
import { ConnectedRouter } from 'connected-react-router'

import bugsnagReact from '@bugsnag/plugin-react'
import { bugsnagClient } from '../src/bugsnag'
import configureStore from '@store/configureStore'
import Routes from '../src/routes'
import stripe from '../src/stripe'
import Cookie from 'js-cookie'
import { history } from '../src/history'

import 'rc-slider/assets/index.css'
import 'core-js/stable'
import 'regenerator-runtime/runtime'

bugsnagClient.use(bugsnagReact, React)

const ErrorBoundary = bugsnagClient.getPlugin('react')

const store = configureStore()
const referrer = document.referrer
Cookie.set('referrer', referrer)

store.dispatch(
  window.me ? {
    type: 'VALIDATE_AUTH_SUCCESS',
    payload: window.me
  } : {
    type: 'VALIDATE_AUTH_FAILURE'
  }
)

const Application = () => (
  <ErrorBoundary>
    <StripeProvider stripe={stripe}>
      <Provider store={store}>
        <ConnectedRouter history={history}>
          <Routes />
        </ConnectedRouter>
      </Provider>
    </StripeProvider>
  </ErrorBoundary>
)

ReactDOM.render(
  <Application />,
  document.getElementById('root')
)
