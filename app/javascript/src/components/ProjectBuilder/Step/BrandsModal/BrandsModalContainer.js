import { connect } from 'react-redux'
import { hideModal } from '@actions/modal'
import BrandsModal from '../../BrandsModal'

export default connect(null, {
  onContinue: hideModal,
})(BrandsModal)
