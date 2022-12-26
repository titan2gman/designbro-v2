import { connect } from 'react-redux'

import Inspirations from './Inspirations'

const mapStateToProps = (state) => ({
  inspirationsExist: state.projectBuilder.attributes.inspirationsExist === 'yes',
  inspirationUploaders: state.projectBuilder.attributes.inspirations
})

export default connect(mapStateToProps)(Inspirations)
