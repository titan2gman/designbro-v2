import { connect } from 'react-redux'
import { showSuccessMessageModal, hideModal } from '@actions/modal'
import { requestManualProject } from '@actions/projectBuilder'
import GetQuoteModal from './GetQuoteModal'

export default connect(null, {
  onClose: hideModal,
  showSuccessMessageModal,
  requestManualProject
})(GetQuoteModal)
