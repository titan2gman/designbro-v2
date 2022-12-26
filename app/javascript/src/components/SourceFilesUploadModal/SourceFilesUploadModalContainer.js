import { connect } from 'react-redux'
import { hideModal } from '@actions/modal'
import SourceFilesUploadModal from './SourceFilesUploadModal'

export default connect(null, {
  onClose: hideModal
})(SourceFilesUploadModal)
