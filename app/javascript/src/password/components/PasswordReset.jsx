import React from 'react'
import { withRouter } from 'react-router-dom'

import PasswordResetForm from '@password/containers/PasswordResetForm'

const Header = () => (
  <div className="main-subheader">
    <div className="container">
      <h1 className="main-subheader__title">Restore password</h1>
    </div>
  </div>
)

const PasswordReset = ({ match }) => (
  <div className="page-main">
    <Header />
    <div className="restore-pass__container container">
      <div className="row">
        <div className="col-md-6 col-lg-5">
          <PasswordResetForm token={match.params.token} />
        </div>
      </div>
    </div>
  </div>
)

export default withRouter(PasswordReset)
