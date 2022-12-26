import { connect } from 'react-redux'

import { getMe } from '@reducers/me'
import { getPayouts } from '@reducers/payouts'
import { getPayoutMinAmount } from '@reducers/payoutMinAmounts'

import DesignerPayouts from '@components/designer/Payouts'

const mapStateToProps = (state) => ({
  payouts: getPayouts(state),
  me: getMe(state),
  payoutMinAmount: getPayoutMinAmount(state)
})

export default connect(mapStateToProps)(DesignerPayouts)
