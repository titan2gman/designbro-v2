import { connect } from 'react-redux'

import { showModal } from '@actions/modal'

import WrongFileFormatModal from '@modals/wrong-file-format/components/WrongFileFormatModal'

const mapDispatchToProps = {
  onClose: () => showModal(
    'UPLOAD_SOURCE_FILES'
  )
}

export default connect(null, mapDispatchToProps)(
  WrongFileFormatModal
)
