import { connect } from 'react-redux'

import DesignersListPage from './DesignersListPage'

import { changeAttributes } from '@actions/projectBuilder'
import { showModal } from '@actions/modal'
import { getProjectBuilderAttributes } from '@selectors/projectBuilder'

const mapStateToProps = (state) => {
  return {
    canContinue: getProjectBuilderAttributes(state).designerId
  }
}

const mergeProps = (stateProps, dispatchProps, ownProps) => {
  return {
    ...stateProps,
    ...dispatchProps,
    ...ownProps,
    onContinue: () => dispatchProps.changeAttributes({ isDesignerChosen: true }),
    onBackButtonClick: () => {
      dispatchProps.changeAttributes({ projectType: undefined })
      dispatchProps.showModal('DESIGNER_OR_CONTEST_DECISION')
    }
  }
}

export default connect(mapStateToProps, {
  changeAttributes,
  showModal
}, mergeProps)(DesignersListPage)
