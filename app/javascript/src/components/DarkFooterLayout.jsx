import React from 'react'
import PropTypes from 'prop-types'

import Footer from '@containers/Footer'
import HeaderDark from '@containers/HeaderDark'

const DarkLayout = ({ children }) => (
  <div className="page-container">
    <HeaderDark />

    {children}

    <Footer />
  </div>
)

DarkLayout.propTypes = {
  children: PropTypes.node
}

export default DarkLayout
