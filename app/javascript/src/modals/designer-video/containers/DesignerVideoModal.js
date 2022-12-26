import { connect } from 'react-redux'

import { hideModal } from '@actions/modal'

import DesignerVideoModal from '@modals/designer-video/components/DesignerVideoModal'

const mapDispatchToProps = {
  onClose: hideModal
}

export default connect(null, mapDispatchToProps)(
  DesignerVideoModal
)
