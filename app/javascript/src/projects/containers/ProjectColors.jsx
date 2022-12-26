import { connect } from 'react-redux'

import ProjectColors from '@projects/components/ProjectColors'

import { getNewColors, getColors, getColorsComment } from '@selectors/projectColors'

const mapStateToProps = (state) => ({
  colors: getNewColors(state) || getColors(state),
  colorsComment: getColorsComment(state)
})

export default connect(mapStateToProps)(ProjectColors)
