import React from 'react'
import PropTypes from 'prop-types'

const ProjectColor = ({ colors, colorsComment }) => (
  <div className="brief-section" id="colors">
    <p className="brief-section__title">Colors to use</p>
    <div className="brief__colors">

      {colors && colors.map((color, index) => (
        <div
          key={index}
          className="color-block"
          style={{ backgroundColor: `${color}` }}
        />
      ))}
    </div>

    {colorsComment && <div className="brief-section__info">
      <p>
        {colorsComment}
      </p>
    </div>}
  </div>
)

ProjectColor.propTypes = {
  colors: PropTypes.arrayOf(PropTypes.object),
  colorsComment: PropTypes.string
}

export default ProjectColor
