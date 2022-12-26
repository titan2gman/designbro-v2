import { connect } from 'react-redux'
import { deleteProject } from '@actions/newProject'

import ProjectCard from '@components/client-brands/ProjectCard'

export default connect(null, {
  deleteProject
})(ProjectCard)
