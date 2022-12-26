import { connect } from 'react-redux'
import { hideModal } from '@actions/modal'
import PaymentModal from './PaymentSuccessModal'

export default connect(null, {
  onClose: hideModal
})(PaymentModal)
