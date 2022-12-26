import React from 'react'
import PropTypes from 'prop-types'

const SignoutButton = ({ onClick: handleClick }) => (
  <div id="logout" className="header__menu-dropdown-link cursor-pointer" onClick={handleClick}>
    Logout
  </div>
)

SignoutButton.propTypes = {
  onClick: PropTypes.func.isRequired
}

export default SignoutButton
