import { connect } from 'react-redux'

import { showModal } from '@actions/modal'

import SourceFilesDropzone from '@components/inputs/SourceFilesDropzone'

const mapDispatchToProps = {
  showWrongFileFormatModal: () => (
    showModal('WRONG_FILE_FORMAT')
  )
}

export default connect(null, mapDispatchToProps)(SourceFilesDropzone)
