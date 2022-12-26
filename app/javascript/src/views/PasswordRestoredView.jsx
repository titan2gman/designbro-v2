import { compose } from 'redux'
import PasswordRestored from '@password/components/PasswordRestored'
import { withDarkFooterLayout } from '../layouts'
import { requireNoAuthentication } from  '../authentication'

export default compose(
  withDarkFooterLayout,
  requireNoAuthentication
)(PasswordRestored)
