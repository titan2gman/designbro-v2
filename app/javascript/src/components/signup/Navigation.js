import React from 'react'
import PropTypes from 'prop-types'
import { Link } from 'react-router-dom'
import classNames from 'classnames'
import { connect } from 'react-redux'

import { loadProject } from '@actions/newProject'
import { showClientLoginModal } from '@actions/modal'

const linkClassName = (active) => (
  classNames('cursor-pointer sign-in__form-nav-item', {
    'sign-in__form-nav-item--active': active
  })
)

const CustomLink = ({ to, text, active, onClick }) => (
  onClick
    ? <div className={linkClassName(active)} onClick={onClick}>{text}</div>
    : <Link to={to} className={linkClassName(active)}>{text}</Link>
)

const SignUpLink = (props) => (
  <CustomLink {...props} active />
)

const LoginLink = (props) => (
  <CustomLink
    {...props}
    to="/login"
    text="Login"
  />
)

const SignupNavigation = (props) => (
  <nav className="sign-in__form-nav">
    <SignUpLink to="/d/signup" text="Join" />
    <LoginLink onClick={props.asModalWindow ? props.showClientLoginModal : null} />
  </nav>
)

SignupNavigation.propTypes = {
  loadProject: PropTypes.func.isRequired,
  asModalWindow: PropTypes.bool.isRequired,
  showClientLoginModal: PropTypes.func.isRequired
}

SignupNavigation.defaultProps = {
  asModalWindow: false
}

const mapDispatchToProps = {
  loadProject, showClientLoginModal
}

export default connect(null, mapDispatchToProps)(
  SignupNavigation
)
