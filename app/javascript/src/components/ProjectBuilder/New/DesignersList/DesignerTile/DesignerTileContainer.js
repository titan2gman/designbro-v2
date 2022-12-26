import { connect } from 'react-redux'
import { changeAttributes } from '@actions/projectBuilder'

import DesignerTile from './DesignerTile'

const mapStateToProps = (state, props) => {
  return {
    isSelected: state.projectBuilder.attributes.designerId === props.winner.id
  }
}

const mergeProps = (stateProps, dispatchProps, ownProps) => {
  return {
    ...stateProps,
    ...dispatchProps,
    ...ownProps,
    onSelect: () => dispatchProps.changeAttributes({ designerId: ownProps.winner.id })
  }
}

export default connect(mapStateToProps, {
  changeAttributes
}, mergeProps)(DesignerTile)
