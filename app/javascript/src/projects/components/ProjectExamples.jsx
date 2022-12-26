import React from 'react'
import PropTypes from 'prop-types'

const ProjectExamples = ({ badExamples, goodExamples }) => (
  <div className="brief-section" id="examples">
    <p className="brief-section__title">
      <i className="brief-section__title-icon icon-check-circle in-green-300 align-middle" />
      Good examples
    </p>

    <div className="brief_example row">
      {goodExamples.map((example) => (
        <div key={example.id} className="col-xs-6 col-lg-3 m-b-25">
          <img src={example.url} alt="good example" />
        </div>
      ))}
    </div>

    {!!badExamples.length && <span>
      <p className="brief-section__title">
        <i className="brief-section__title-icon icon-cross-circle in-pink-500 align-middle" />
        Bad examples
      </p>

      <div className="brief_example row">
        {badExamples.map((example) => (
          <div key={example.id} className="col-xs-6 col-lg-3 m-b-25">
            <img src={example.url} alt="bad example" />
          </div>
        ))}
      </div>
    </span>}
  </div>
)

ProjectExamples.propTypes = {
  badExamples: PropTypes.arrayOf(PropTypes.object),
  goodExamples: PropTypes.arrayOf(PropTypes.object)
}

export default ProjectExamples
