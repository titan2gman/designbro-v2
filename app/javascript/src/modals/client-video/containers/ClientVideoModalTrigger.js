import { connect } from 'react-redux'

import { showClientVideoModal } from '@actions/modal'

import ClientVideoModalTrigger from '@modals/client-video/components/ClientVideoModalTrigger'

const mapDispatchToProps = {
  onClick: showClientVideoModal
}

const makeTrigger = (Trigger) => (
  connect(null, mapDispatchToProps)(
    Trigger
  )
)

export default {
  White: makeTrigger(ClientVideoModalTrigger.White),
  Black: makeTrigger(ClientVideoModalTrigger.Black)
}
