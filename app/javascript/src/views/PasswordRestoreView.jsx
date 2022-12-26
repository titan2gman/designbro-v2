import { compose } from 'redux'
import PasswordRestore from '@password/components/PasswordRestore'
import { withDarkFooterLayout } from '../layouts'
import { requireNoAuthentication } from  '../authentication'

export default compose(
  withDarkFooterLayout,
  requireNoAuthentication
)(PasswordRestore)
