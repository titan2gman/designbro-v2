import { connect } from 'react-redux'

import AdditionalDocuments from './AdditionalDocuments'

const mapStateToProps = (state) => ({
  additionalDocumentUploaders: state.projectBuilder.attributes.projectAdditionalDocuments
})

export default connect(mapStateToProps)(AdditionalDocuments)
