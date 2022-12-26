import { connect } from 'react-redux'

import { hideModal } from '@actions/modal'

import ClientVideoModal from '@modals/client-video/components/ClientVideoModal'

const mapDispatchToProps = {
  onClose: hideModal
}

export default connect(null, mapDispatchToProps)(
  ClientVideoModal
)
