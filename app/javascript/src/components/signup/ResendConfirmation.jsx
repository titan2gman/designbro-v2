import React from 'react'
import ResendConfirmationForm from '../../containers/signup/ResendConfirmationForm'

const Header = () => (
  <div className="main-subheader">
    <div className="container">
      <h1 className="main-subheader__title">Send invitation</h1>
    </div>
  </div>
)

const EmailResend = () => (
  <main className="page-main">
    <Header />
    <div className="restore-pass__container container">
      <ResendConfirmationForm />
    </div>
  </main>
)

export default EmailResend
