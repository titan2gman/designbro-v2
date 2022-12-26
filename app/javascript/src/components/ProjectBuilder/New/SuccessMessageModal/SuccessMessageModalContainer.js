import { connect } from 'react-redux'
import { hideModal } from '@actions/modal'
import PaymentModal from './SuccessMessageModal'

export default connect(null, {
  onClose: hideModal
})(PaymentModal)
