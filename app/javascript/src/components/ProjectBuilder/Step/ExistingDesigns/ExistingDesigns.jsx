import React from 'react'
import PropTypes from 'prop-types'

import { RadioButton, ExistingDesignUploader } from '../../inputs'

const ExistingDesigns = ({ existingDesignsExist, existingDesignUploaders }) => (
  <div className="bfs-existing-design">
    <p className="bfs-hint__text">
      Do you already have an existing design you would like to change?
    </p>

    <div className="m-b-10">
      <span className="main-radio m-r-20">
        <RadioButton
          label="No"
          value="no"
          name="existingDesignsExist"
        />
      </span>

      <span className="main-radio">
        <RadioButton
          label="Yes"
          value="yes"
          name="existingDesignsExist"
        />
      </span>
    </div>

    {existingDesignsExist && (
      <div className="bfs-content__upload-box row">
        {existingDesignUploaders.map((uploader, index) => (
          <ExistingDesignUploader
            key={index}
            index={index}
          />
        ))}
      </div>
    )}
  </div>
)

ExistingDesigns.propTypes = {
  existingDesignsExist: PropTypes.bool.isRequired,
  existingDesignUploaders: PropTypes.array
}

export default ExistingDesigns
