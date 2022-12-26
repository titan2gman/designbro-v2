import { connect } from 'react-redux'

import { showDesignerVideoModal } from '@actions/modal'

import DesignerVideoModalTrigger from '@modals/designer-video/components/DesignerVideoModalTrigger'

const mapDispatchToProps = {
  onClick: showDesignerVideoModal
}

export default connect(null, mapDispatchToProps)(
  DesignerVideoModalTrigger
)
