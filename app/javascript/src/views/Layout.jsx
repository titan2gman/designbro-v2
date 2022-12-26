import React, { Fragment } from 'react'
import PropTypes from 'prop-types'
import HeaderLight from '../containers/HeaderLight'
import HeaderDark from '../containers/HeaderDark'

const Layout = ({ theme, children }) => {
  if (theme === 'light') {
    return (
      <div className="container">
        <HeaderLight />

        {children}
      </div>
    )
  }

  return (
    <Fragment>
      <HeaderDark />

      {children}
    </Fragment>
  )
}

Layout.propTypes = {
  children: PropTypes.node
}

export default Layout
