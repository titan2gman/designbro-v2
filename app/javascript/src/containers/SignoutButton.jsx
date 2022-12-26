import { connect } from 'react-redux'
import { history } from '../history'

import { signOutAndCleanHeaders } from '@actions/auth'
import { cleanHeadersInCookies } from '@utils/auth'

import SignoutButton from '@components/SignoutButton'

export default connect(null, {
  onClick: signOutAndCleanHeaders
})(SignoutButton)
