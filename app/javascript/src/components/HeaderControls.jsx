import React from 'react'
import PropTypes from 'prop-types'
import { Link, withRouter } from 'react-router-dom'

import { staticHost } from '@utils/hosts'

import includesByRegex from '@utils/includesByRegex'

class HeaderControls extends React.Component {
  get isStartProjectVisible () {
    const urls = [
      '/projects/new/'
    ]

    return includesByRegex(urls, this.props.location.pathname)
  }

  get isLoginVisible () {
    const urls = [
      '/projects/new/'
    ]

    return includesByRegex(urls, this.props.location.pathname)
  }

  render () {
    return (
      <div className="hidden-xs-down">
        {this.isStartProjectVisible &&
          <a
            href={`${staticHost}/design-project-types`}
            className="main-header__cta main-button main-button--md main-button--black-pink">

            Start a Project
          </a>
        }
        {this.isLoginVisible &&
          <Link
            to="/login"
            className="main-header__cta main-button main-button--md main-button--clear-white">

            Login
          </Link>
        }
      </div>
    )
  }
}

HeaderControls.propTypes = {
  location: PropTypes.shape({
    pathname: PropTypes.string.isRequired
  }).isRequired
}

export default withRouter(HeaderControls)
