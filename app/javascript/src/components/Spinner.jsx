import React from 'react'
import PropTypes from 'prop-types'

const renderChildren = (children) => (
  typeof children === 'function'
    ? children() : children
)

const Layout = ({ text }) => (
  <div className="font-13 in-grey-450 text-center spinner">
    <svg width="45" height="45" viewBox="0 0 45 45" className="spinner-img">
      <linearGradient id="linear-gradient">
        <stop offset="0%" stopColor="#808080" />
        <stop offset="100%" stopColor="#808080" stopOpacity="0" />
      </linearGradient>

      <path fill="url(#linear-gradient)" d="M0,22.5A22.5,22.5,0,1,0,22.5,0,22.5,22.5,0,0,0,0,22.5Zm41,0A18.5,18.5,0,1,1,22.5,4,18.5,18.5,0,0,1,41,22.5Z" />
    </svg>

    <p>{text}</p>
  </div>
)

Layout.propTypes = {
  text: PropTypes.string.isRequired
}

const Spinner = ({ text, loading, children }) => (
  loading
    ? <Layout text={text} />
    : renderChildren(children)
)

Spinner.propTypes = {
  text: PropTypes.string.isRequired,
  loading: PropTypes.bool.isRequired
}

Spinner.defaultProps = {
  text: 'Loading'
}

export default Spinner
