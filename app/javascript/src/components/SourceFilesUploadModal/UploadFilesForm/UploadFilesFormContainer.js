import _ from 'lodash'
import { connect } from 'react-redux'

import { upload } from '@actions/sourceFiles'

import { getProjectById } from '@reducers/projects'
import { getSourceFiles } from '@reducers/sourceFiles'

import UploadFilesForm from './UploadFilesForm'

const mapStateToProps = (state) => {
  const files = getSourceFiles(state)

  return {
    projectId: state.projects.current,
    files,
    canContinue: !_.isEmpty(files)
  }
}

export default connect(mapStateToProps, {
  upload,
})(UploadFilesForm)
