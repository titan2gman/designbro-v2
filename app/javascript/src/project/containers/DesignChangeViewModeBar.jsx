import { connect } from 'react-redux'
import { changeViewMode } from '@actions/designs'
import { getViewMode } from '@reducers/designs'
import DesignChangeViewModeBar from '@project/components/DesignChangeViewModeBar'

const mapStateToProps = (state) => {
  return {
    viewMode: getViewMode(state)
  }
}

export default connect(mapStateToProps, {
  onChange: changeViewMode
})(DesignChangeViewModeBar)
