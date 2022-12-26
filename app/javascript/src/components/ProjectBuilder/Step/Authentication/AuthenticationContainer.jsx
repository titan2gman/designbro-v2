import { connect } from 'react-redux'
import { isAuthenticated, isAuthFormVisible } from '@reducers/me'

import Authentication from './Authentication'

const mapStateToProps = (state) => {
  return {
    isAuthFormVisible: isAuthFormVisible(state),
    authenticated: isAuthenticated(state),
  }
}

export default connect(mapStateToProps)(Authentication)
