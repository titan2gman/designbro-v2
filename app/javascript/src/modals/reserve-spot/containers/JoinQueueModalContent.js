import { connect } from 'react-redux'

import { hideModal } from '@actions/modal'
import { joinQueue } from '@actions/projects'

import JoinQueueModalContent from '@modals/reserve-spot/components/JoinQueueModalContent'

const handleJoinQueue = (project) => (dispatch) => {
  dispatch(joinQueue(project.id)).then(() => {
    dispatch(hideModal())
  })
}

const mapDispatchToProps = {
  hideModal, handleJoinQueue
}

const mergeProps = (_, { handleJoinQueue, ...dispatchProps }, ownProps) => ({
  ...dispatchProps, handleJoinQueue: () => handleJoinQueue(ownProps.project), ...ownProps
})

export default connect(null, mapDispatchToProps, mergeProps)(
  JoinQueueModalContent
)
