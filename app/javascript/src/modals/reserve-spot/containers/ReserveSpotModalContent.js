import { connect } from 'react-redux'
import { history } from '../../../history'

import { hideModal } from '@actions/modal'
import { reserveSpot } from '@actions/projects'
import { incrementActiveSpotsCount } from '@actions/designer'

import ReserveSpotModalContent from '@modals/reserve-spot/components/ReserveSpotModalContent'

const handleReserve = (project) => (dispatch) => {
  dispatch(reserveSpot(project.id)).then(() => {
    history.push(`/d/projects/${project.id}/designs`)
    dispatch(incrementActiveSpotsCount())
    dispatch(hideModal())
  })
}

const mapDispatchToProps = {
  hideModal, handleReserve
}

const mergeProps = (_, { handleReserve, ...dispatchProps }, ownProps) => ({
  ...dispatchProps, handleReserve: () => handleReserve(ownProps.project), ...ownProps
})

export default connect(null, mapDispatchToProps, mergeProps)(
  ReserveSpotModalContent
)
