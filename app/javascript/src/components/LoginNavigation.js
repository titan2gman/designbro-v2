import React from 'react'
import PropTypes from 'prop-types'
import { Link } from 'react-router-dom'
import classNames from 'classnames'
import { connect } from 'react-redux'

import { loadProject } from '@actions/newProject'
import { showClientSignUpModal } from '@actions/modal'

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

const SignUpLink = CustomLink

const LoginLink = () => (
  <CustomLink
    to="/login"
    text="Login"
    active
  />
)
const LoginNavigation = (props) => (
  <nav className="sign-in__form-nav">
    <SignUpLink to="/d/signup" text="Join" onClick={props.asModalWindow ? props.showClientSignUpModal : null} />
    <LoginLink />
  </nav>
)

LoginNavigation.propTypes = {
  loadProject: PropTypes.func.isRequired,
  asModalWindow: PropTypes.bool.isRequired,
  showClientSignUpModal: PropTypes.func.isRequired
}

LoginNavigation.defaultProps = {
  asModalWindow: false
}

const mapDispatchToProps = {
  loadProject, showClientSignUpModal
}

export default connect(null, mapDispatchToProps)(
  LoginNavigation
)
