import classNames from 'classnames'

import React from 'react'
import PropTypes from 'prop-types'
import { Link } from 'react-router-dom'

import SignupNavigation from './Navigation'

import EmailClientForm from '../../containers/signup/EmailClientForm'

const SaveWorkHint = () => (
  <p className="m-b-35 font-bold">
    Sign up now to save your work!
  </p>
)

const LoginHint = () => (
  <p className="sign-in__form-text-md">
    Already have an account? <Link className="sign-in__form-link-pink" to="/login">Login</Link>
  </p>
)

const SignupClient = ({ showSaveWorkHint, asModalWindow }) => (
  <main className="sign-in__container">
    <div className={classNames('sign-in__form', { 'm-b-0': asModalWindow })}>
      <SignupNavigation asModalWindow={asModalWindow} />

      {showSaveWorkHint && <SaveWorkHint />}

      <EmailClientForm />
      <LoginHint />
    </div>
  </main>
)

SignupClient.propTypes = {
  asModalWindow: PropTypes.bool.isRequired,
  showSaveWorkHint: PropTypes.bool.isRequired
}

SignupClient.defaultProps = {
  showSaveWorkHint: false,
  asModalWindow: false
}

export default SignupClient
