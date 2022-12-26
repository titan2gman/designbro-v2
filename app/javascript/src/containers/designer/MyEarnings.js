import { connect } from 'react-redux'
import { getMe } from '@reducers/me'
import { getEarnings } from '@reducers/earnings'
import { getPayoutMinAmount } from '@reducers/payoutMinAmounts'

import DesignerMyEarnings from '@components/designer/MyEarnings'

const mapStateToProps = (state) => ({
  me: getMe(state),
  earnings: getEarnings(state),
  payoutMinAmount: getPayoutMinAmount(state)
})

export default connect(mapStateToProps)(DesignerMyEarnings)
