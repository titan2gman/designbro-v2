import React from 'react'
import PropTypes from 'prop-types'

import { RadioButton, CompetitorLogoUploader } from '../../inputs'

const Competitors = ({ competitorsExist, competitorUploaders }) => (
  <div className="bfs-competitors-block">
    <div className="row">
      <div className="col-md-8">
        <p className="bfs-hint__text">
          Can you show us your competition?
        </p>
      </div>
    </div>

    <div className="m-b-10">
      <label className="main-radio m-r-20">
        <RadioButton
          label="No"
          value="no"
          name="competitorsExist"
        />
      </label>

      <label className="main-radio">
        <RadioButton
          label="Yes"
          value="yes"
          name="competitorsExist"
        />
      </label>
    </div>

    {competitorsExist && competitorUploaders.map((uploader, index) => (
      <CompetitorLogoUploader
        key={index}
        index={index}
      />
    ))}
  </div>
)

const competitorUploaderShape = PropTypes.shape({
  uploadedFileId: PropTypes.string
})

Competitors.propTypes = {
  competitorsExist: PropTypes.bool.isRequired,
  competitorUploaders: PropTypes.arrayOf(
    competitorUploaderShape
  ).isRequired
}

export default Competitors
