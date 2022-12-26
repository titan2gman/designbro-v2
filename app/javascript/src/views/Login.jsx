import { compose } from 'redux'
import Login from '@login/components/Login'
import { withSigninLayout } from '../layouts'
import { requireNoAuthentication } from  '../authentication'

export default compose(
  withSigninLayout,
  requireNoAuthentication
)(Login)
