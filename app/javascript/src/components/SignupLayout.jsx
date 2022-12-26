import React from 'react'
import PropTypes from 'prop-types'

import Footer from '@containers/Footer'
import HeaderDesigner from '@components/HeaderDesigner'

const SignupLayout = ({ children }) => (
  <div className="page-container">
    <HeaderDesigner registration />
    {children}
    <Footer />
  </div>
)

SignupLayout.propTypes = {
  children: PropTypes.node
}

export default SignupLayout
