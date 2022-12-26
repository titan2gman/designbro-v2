import { connect } from 'react-redux'

import ColorsBody from './ColorsBody'

const mapStateToProps = (state) => ({
  colors: state.projectBuilder.attributes.colors
})

export default connect(mapStateToProps)(ColorsBody)
