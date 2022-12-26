import { connect } from 'react-redux'

import { getMe } from '@reducers/me'
import { getDesign } from '@reducers/designs'
import { getProject } from '@reducers/projects'
import { getVersions, getSelectedVersion } from '@reducers/designVersions'
import { selectVersion } from '@actions/designVersions'

import DesignVersionsPanel from '@project/components/DesignVersionsPanel'

const mapStateToProps = (state) => {
  const design = getDesign(state)
  const imageId = design && design.imageId.toString()
  const versions = getVersions(state).sort((a, b) => (
    parseInt(b.id, 10) - parseInt(a.id, 10)
  ))

  return {
    design,
    versions,

    project: getProject(state),
    userType: getMe(state).userType,
    loading: state.designVersions.loading,
    selected: getSelectedVersion(state) || imageId
  }
}

const mapDispatchToProps = {
  onClick: selectVersion
}

export default connect(mapStateToProps, mapDispatchToProps)(DesignVersionsPanel)
