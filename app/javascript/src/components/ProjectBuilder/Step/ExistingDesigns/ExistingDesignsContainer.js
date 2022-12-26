import { connect } from 'react-redux'

import ExistingDesigns from './ExistingDesigns'

const mapStateToProps = (state) => ({
  existingDesignsExist: state.projectBuilder.attributes.existingDesignsExist === 'yes',
  existingDesignUploaders: state.projectBuilder.attributes.existingDesigns
})

export default connect(mapStateToProps)(ExistingDesigns)
