import { connect } from 'react-redux'

import { hideModal } from '@actions/modal'
import { getMe } from '@reducers/me'

import ReserveSpotModal from '@modals/reserve-spot/components/ReserveSpotModal'

const mapStateToProps = (state) => {
  return { me: getMe(state) }
}

const mapDispatchToProps = {
  hideModal
}

export default connect(mapStateToProps, mapDispatchToProps)(
  ReserveSpotModal
)
