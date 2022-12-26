import React from 'react'

const Header = () => (
  <div className="main-subheader">
    <div className="container">
      <h1 className="main-subheader__title">Success!</h1>
    </div>
  </div>
)

const PasswordRestored = () => (
  <div className="page-main">
    <Header />
    <div className="restore-pass__container container">
      <p>Email with password reset link have been sent to the email you specified</p>
    </div>
  </div>
)

export default PasswordRestored
