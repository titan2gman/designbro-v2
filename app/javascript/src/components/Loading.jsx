import React from 'react'
import PropTypes from 'prop-types'

import Spinner from '@components/Spinner'

const Loading = ({ children, state }) => state ? <Spinner /> : children

Loading.propTypes = {
  children: PropTypes.node.isRequired,
  state: PropTypes.bool
}

export default Loading
