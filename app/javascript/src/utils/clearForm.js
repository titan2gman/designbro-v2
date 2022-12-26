import PropTypes from 'prop-types'
import React, { Component } from 'react'
import { actions } from 'react-redux-form'

export default (...forms) => (Wrappable) => {
  class Wrapper extends Component {

    render () {
      return <Wrappable {...this.props} />
    }
  }

  Wrapper.contextTypes = {
    store: PropTypes.object.isRequired
  }

  return Wrapper
}
