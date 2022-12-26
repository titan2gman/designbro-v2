import React from 'react'
import PropTypes from 'prop-types'
import { Link } from 'react-router-dom'

const NewProject = ({ brandId }) => (
  <Link to={`/projects/new?brand_id=${brandId}`}>
    <div className="project-card new-project">
      <div className="plus">+</div>
      <div className="start">Start a new project</div>
    </div>
  </Link>
)

NewProject.propTypes = {
}


export default NewProject
