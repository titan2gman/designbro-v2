import React, { Fragment } from 'react'
import PropTypes from 'prop-types'
import { Link } from 'react-router-dom'
import { Divider } from 'semantic-ui-react'

import BrandHeader from './BrandHeader'
import NewProject from './NewProject'
import ProjectCard from '../../containers/client-brands/ProjectCard'
import ProjectsPager from '../../containers/ProjectsPager'

const dividers = [
  'In progress',
  'Briefing details needed',
  'Payment needed'
]

const ProjectsInProgressList = ({ brand, groupedProjects, loadProjects }) => (
  <main className="projects-list">
    <BrandHeader brand={brand} />

    {dividers.map((divider) => {
      return groupedProjects[divider] ? (
        <Fragment key={divider}>
          <Divider horizontal>{divider}</Divider>

          {groupedProjects[divider].map((project) => (
            <ProjectCard
              key={project.id}
              project={project}
            />
          ))}
        </Fragment>
      ) : null
    })}

    {brand && <NewProject brandId={brand.id} />}

    {/* god clent only */}
    {!brand && (
      <div className="text-center">
        <ProjectsPager
          loadProjects={() => {
            loadProjects({
              state_in: ['design_stage', 'finalist_stage', 'files_stage', 'review_files']
            })
          }}
        />
      </div>
    )}
  </main>
)

ProjectsInProgressList.propTypes = {
  brands: PropTypes.object.isRequired
}

export default ProjectsInProgressList
