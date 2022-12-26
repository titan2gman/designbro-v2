import React from 'react'
import { Switch, Route } from 'react-router-dom'

import HeaderError from '@components/HeaderError'

import NotFoundError from '@static/errors/components/NotFoundError'
import InternalServerError from '@static/errors/components/InternalServerError'
import LinkExpired from '@static/errors/components/LinkExpired'
import UnsubscribedEmail from '@static/emails/UnsubscribedEmail'

const ErrorLayout = () => (
  <div className="container">
    <HeaderError />

    <Switch>
      <Route path="/errors/link-expired" component={LinkExpired} />
      <Route path="/errors/500" component={InternalServerError} />
      <Route path="/errors/404" component={NotFoundError} />
      <Route path="/emails/abandoned-cart/unsubscribe" component={UnsubscribedEmail} />

      <Route component={NotFoundError} />
    </Switch>
  </div>
)

export default ErrorLayout
