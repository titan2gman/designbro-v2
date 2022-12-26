import React from 'react'
import PropTypes from 'prop-types'

import HeaderDark from '@containers/HeaderDark'

const DarkLayout = ({ children }) => (
  <div className="page-container">
    <HeaderDark />

    {children}
  </div>
)

DarkLayout.propTypes = {
  children: PropTypes.node
}

export default DarkLayout
