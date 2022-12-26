import { connect } from 'react-redux'

import ColorsPicker from './ColorsPicker'

const mapStateToProps = (state) => ({
  colorsExist: state.projectBuilder.attributes.colorsExist === 'yes'
})

export default connect(mapStateToProps)(ColorsPicker)
