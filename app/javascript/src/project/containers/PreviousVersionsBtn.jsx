import { connect } from 'react-redux'
import { getDesign } from '@reducers/designs'
import PreviousVersionsBtn from '@project/components/PreviousVersionsBtn'

const mapStateToProps = (state, ownProps) => {
  const design = getDesign(state)
  return {
    disabled: !!design && design.banned,
    className: ownProps.className
  }
}

export default connect(mapStateToProps)(PreviousVersionsBtn)
