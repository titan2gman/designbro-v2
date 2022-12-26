import { connect } from 'react-redux'

import { showAdditionalTimeModal } from '@actions/modal'
import { MAX_ADDITIONAL_DAYS } from '@constants'

import { getStateTime } from '@utils/dateTime'

import { getMe } from '@reducers/me'

import ProjectTime from '@components/ProjectTime'
import includes from 'lodash/includes'

const showProjectTimeStatuses = [
  'design_stage',
  'finalist_stage',
  'files_stage',
  'review_files'
]

const getClientStageHint = (projectType, projectState) => {
  const clientStageHints = {
    'design_stage': projectType === 'contest' ? ' left to choose your finalists' : ' left in the Design Stage',
    'finalist_stage': projectType === 'contest' ? ' left to choose your winner' : ' left to approve the design',
    'files_stage': ' for the designer to upload files',
    'review_files': ' left to approve the files'
  }

  return clientStageHints[projectState]
}

const getDesignerStageHint = (projectType, projectState) => {
  const designerStageHint = {
    'design_stage': ' left in the Design Stage',
    'finalist_stage': projectType === 'contest' ? ' left in the Finalist Stage' : ' left for the client approval',
    'files_stage': ' left to upload your files',
    'review_files': ' left for the client approval'
  }

  return designerStageHint[projectState]
}

const getTimeHint = (project, userType) => {
  switch (userType) {
  case 'client':
    return getClientStageHint(project.projectType, project.state)
  case 'designer':
    return getDesignerStageHint(project.projectType, project.state)
  default:
    return ''
  }
}

const mapStateToProps = (state, { project }) => {
  const userType = getMe(state).userType

  return {
    project,
    isBuyTimeVisible: (userType === 'client') && ['design_stage', 'finalist_stage'].includes(project.state) && (MAX_ADDITIONAL_DAYS > project.additionalDays),
    stats: getStateTime(project),
    hint: getTimeHint(project, getMe(state).userType),
    show: includes(showProjectTimeStatuses, project.state)
  }
}

export default connect(mapStateToProps, {
  showAdditionalTimeModal
})(ProjectTime)
