import { compose } from 'redux'
import { connect } from 'react-redux'
import { withSpinner } from '@components/withSpinner'
import { showModal } from '@actions/modal'
import { createDesignerNda } from '@actions/designerNdas'

import { getMyProjects, canDiscoverProjects } from '@selectors/myProjects'

import DesignerDashboardProjects from '@components/designer-dashboard/DesignerDashboardProjects'

const mapStateToProps = (state) => {
  return {
    projects: getMyProjects(state),
    canDiscoverProjects: canDiscoverProjects(state),
    inProgress: state.myProjects.inProgress || state.productCategories.inProgress
  }
}

export default compose(
  connect(mapStateToProps, {
    showModal,
    createDesignerNda
  }),
  withSpinner,
)(DesignerDashboardProjects)
