import partial from 'lodash/partial'

import { connect } from 'react-redux'
import { showModal } from '@actions/modal'

import ReserveSpotModalTrigger from '@modals/reserve-spot/components/ReserveSpotModalTrigger'

const mapDispatchToProps = {
  showReserveSpotModal: (project) => (
    showModal('RESERVE_SPOT', { project })
  )
}

const mergeProps = (_, { showReserveSpotModal }, { project, ...props }) => ({
  ...props, showReserveSpotModal: partial(showReserveSpotModal, project)
})

export default connect(null, mapDispatchToProps, mergeProps)(
  ReserveSpotModalTrigger
)
