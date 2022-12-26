import PropTypes from 'prop-types'

const HiddenInTestEnvironment = ({ children }) => {
  return window.env === 'test' ? null : children
}

HiddenInTestEnvironment.propTypes = {
  children: PropTypes.node.isRequired
}

export default HiddenInTestEnvironment
