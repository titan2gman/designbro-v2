import { connect } from 'react-redux'
import { showModal, hideModal } from '@actions/modal'
import { changeAttributes } from '@actions/projectBuilder'
import BrandsModal from '../../BrandsModal'
import { getFinalistDesigners } from '@selectors/finalistDesigners'

const mapStateToProps = (state) => {
  return {
    hasDesigners: getFinalistDesigners(state).length > 0
  }
}

const mergeProps = (stateProps, dispatchProps, ownProps) => {
  return {
    ...stateProps,
    ...dispatchProps,
    ...ownProps,
    onContinue: () => {
      dispatchProps.hideModal()
      if (stateProps.hasDesigners) {
        dispatchProps.showModal('DESIGNER_OR_CONTEST_DECISION')
      } else {
        dispatchProps.changeAttributes({ projectType: 'contest' })
      }
    },
  }
}

export default connect(mapStateToProps, {
  showModal,
  hideModal,
  changeAttributes
}, mergeProps)(BrandsModal)
