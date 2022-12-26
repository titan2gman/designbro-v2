import { connect } from 'react-redux'

import Success from './Success'

import { getCurrentProject } from '@selectors/projects'

const mapStateToProps = (state) => {
  const project = getCurrentProject(state)

  return {
    project
  }
}

export default connect(mapStateToProps)(Success)
