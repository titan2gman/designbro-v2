import { connect } from 'react-redux'
import { hideModal } from '@actions/modal'
import { changeAttributes } from '@actions/projectBuilder'
import DesignerOrContestDecisionModal from './DesignerOrContestDecisionModal'

const mergeProps = (stateProps, dispatchProps, ownProps) => {
  return {
    ...stateProps,
    ...dispatchProps,
    ...ownProps,
    selectOneToOne: () => {
      dispatchProps.changeAttributes({ projectType: 'one_to_one' })
      dispatchProps.hideModal()
    },
    selectContest: () => {
      dispatchProps.changeAttributes({ projectType: 'contest' })
      dispatchProps.hideModal()
    },
  }
}


export default connect(null, {
  changeAttributes,
  hideModal
}, mergeProps)(DesignerOrContestDecisionModal)
