import React, { Fragment } from 'react'
import PropTypes from 'prop-types'
import { Link } from 'react-router-dom'

import NewProject from './NewProject'
import BrandHeader from './BrandHeader'
import ProjectCard from '../../containers/client-brands/ProjectCard'

import ProjectsPager from '../../containers/ProjectsPager'

const ProjectsCompletedList = ({ brand, groupedProjects, loadProjects }) => (
  <main className="projects-list">
    <BrandHeader brand={brand} />

    {groupedProjects['Completed'] && groupedProjects['Completed'].map((project) => (
      <ProjectCard
        key={project.id}
        project={project}
      />
    ))}

    {/* god clent only */}
    {!brand && (
      <div className="text-center">
        <ProjectsPager
          loadProjects={() => {
            loadProjects({
              state_in: ['completed']
            })
          }}
        />
      </div>
    )}
  </main>
)

ProjectsCompletedList.propTypes = {
  brands: PropTypes.object.isRequired
}

export default ProjectsCompletedList
