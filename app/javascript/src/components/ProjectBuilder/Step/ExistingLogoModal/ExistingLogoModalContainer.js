import { connect } from 'react-redux'

import { closeExistingLogoModal } from '@actions/projectBuilder'

import ExistingLogoModal from './ExistingLogoModal'

export default connect(null, {
  onClose: closeExistingLogoModal
})(ExistingLogoModal)
