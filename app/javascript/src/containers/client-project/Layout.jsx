import { compose } from 'redux'
import { connect } from 'react-redux'
import { withSpinner } from '@components/withSpinner'
import { withNewProjectGuard } from '../../newProjectGuard'

import { getCurrentProject } from '@selectors/projects'
import { getCurrentBrand } from '@selectors/brands'

import Layout from '@components/client-project/Layout'

const mapStateToProps = (state) => {
  return {
    inProgress: state.projects.inProgress,
    project: getCurrentProject(state),
    brand: getCurrentBrand(state)
  }
}

export default compose(
  connect(mapStateToProps),
  withSpinner,
  withNewProjectGuard
)(Layout)
