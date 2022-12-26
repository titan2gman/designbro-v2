import { compose } from 'redux'

import { withDarkFooterLayout } from '../layouts'
import { requireClientAuthentication } from '../authentication'

import ClientTransactions from '@client/containers/transactions/ClientTransactions'

export default compose(
  withDarkFooterLayout,
  requireClientAuthentication
)(ClientTransactions)
