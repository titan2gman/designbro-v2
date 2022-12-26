import React from 'react'
import PasswordRestoreForm from '@password/containers/PasswordRestoreForm'

const Header = () => (
  <div className="main-subheader">
    <div className="container">
      <h1 className="main-subheader__title">Restore password</h1>
    </div>
  </div>
)

const PasswordRestore = () => (
  <div className="page-main">
    <Header />
    <div className="restore-pass__container container">
      <div className="row">
        <PasswordRestoreForm />
      </div>
    </div>
  </div>
)

export default PasswordRestore
