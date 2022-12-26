import { connect } from 'react-redux'

import { hideModal } from '@actions/modal'

import DesignerShareConfirmModal from '@modals/designer-share-confirm/components/DesignerShareConfirmModal'

export default connect(null, {
  hideModal
})(DesignerShareConfirmModal)
