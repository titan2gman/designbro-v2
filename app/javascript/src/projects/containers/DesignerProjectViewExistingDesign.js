import { connect } from 'react-redux'

import { getMe } from '@reducers/me'
import { getSpotById } from '@reducers/spots'

import DesignerProjectViewExistingDesign from '@projects/components/DesignerProjectViewExistingDesign'

const mapStateToProps = (state, { design }) => {
  const spot = getSpotById(state, design.spot)
  const showDesignInfo = design.designer === getMe(state).id

  return {
    spot,
    showDesignInfo,
    loading: !spot
  }
}

export default connect(mapStateToProps)(DesignerProjectViewExistingDesign)
