import { connect } from 'react-redux'

import OptionalBrandSelector from './OptionalBrandSelector'

const mapStateToProps = (state) => ({
  brandExists: state.projectBuilder.attributes.brandExists === 'yes',
})

export default connect(mapStateToProps)(OptionalBrandSelector)
