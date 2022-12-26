import { connect } from 'react-redux'

import ErrorMessage from './ErrorMessage'

const mapStateToProps = (state) => ({
  error: state.projectBuilder.validation.creditCard
})

export default connect(mapStateToProps)(ErrorMessage)
