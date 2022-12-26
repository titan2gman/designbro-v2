import { compose } from 'redux'
import SignupResendConfirmation from '../components/signup/ResendConfirmation'
import { withDarkFooterLayout } from '../layouts'
import { requireNoAuthentication } from  '../authentication'

export default compose(
  withDarkFooterLayout,
  requireNoAuthentication
)(SignupResendConfirmation)
