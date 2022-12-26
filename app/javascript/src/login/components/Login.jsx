import classNames from 'classnames'

import React from 'react'
import PropTypes from 'prop-types'
import { Link } from 'react-router-dom'

import { staticHost } from '@utils/hosts'

import LoginForm from '@login/containers/LoginForm'
import LoginNavigation from '@components/LoginNavigation'

const SaveWorkHint = () => (
  <p className="m-b-35 font-bold">
    Log in now to save your work!
  </p>
)

const SignupSwitch = () => (
  <p className="sign-in__form-text">
    <a href={`${staticHost}/design-project-types`} className="sign-in__form-link in-black no-wrap">
      Start a project as a client
    </a>

    <span className="m-l-5 m-r-5"> or </span>

    <Link to="/d/signup" className="sign-in__form-link in-green-500 no-wrap">
      Register as a designer
    </Link>
  </p>
)

const NoAccountHint = () => (
  <p className="sign-in__form-text-md">
    Don’t have an account?
  </p>
)

const Login = ({ history, showSaveWorkHint, asModalWindow, showNavigation, showRegisterHint }) => (
  <main className="sign-in__container">
    <div className={classNames('sign-in__form', { 'm-b-0': asModalWindow })}>
      {showNavigation && <LoginNavigation asModalWindow={asModalWindow} />}
      {showSaveWorkHint && <SaveWorkHint />}

      <LoginForm history={history} />

      {showRegisterHint && [
        <NoAccountHint key="no-acc-hint" />,
        <SignupSwitch key="signup-switch" />
      ]}
    </div>
  </main>
)

Login.propTypes = {
  asModalWindow: PropTypes.bool.isRequired,
  showNavigation: PropTypes.bool.isRequired,
  showSaveWorkHint: PropTypes.bool.isRequired,
  showRegisterHint: PropTypes.bool.isRequired
}

Login.defaultProps = {
  asModalWindow: false,
  showNavigation: true,
  showRegisterHint: true,
  showSaveWorkHint: false
}

export default Login
