import React from 'react'
import PropTypes from 'prop-types'

import { RadioButton, ExistingDesignUploader } from '../../inputs'

const ExistingLogos = ({ productName, hasExistingDesigns, existingDesignsExist, existingDesignUploaders, showFinishStepLogoModal }) => (
  hasExistingDesigns ? (
    <div className="bfs-existing-design">
      <p className="bfs-hint__text">
        Do you want to use your existing logo?
      </p>

      <div className="m-b-10">
        <span className="main-radio">
          <RadioButton
            label="Yes"
            value="yes"
            name="sourceFilesShared"
          />
        </span>

        <span className="main-radio">
          <RadioButton
            label={`Don't need a logo to be featured on my ${productName}`}
            value="no"
            name="sourceFilesShared"
          />
        </span>
      </div>
    </div>
  ) : (
    <div className="bfs-existing-design">
      <p className="bfs-hint__text">
        Do you already have a logo?
      </p>

      <div className="m-b-10">
        <span className="main-radio">
          <RadioButton
            label="Yes"
            value="yes"
            name="existingDesignsExist"
          />
        </span>

        <span className="main-radio">
          <RadioButton
            label="No"
            value="popup"
            name="existingDesignsExist"
            onChange={showFinishStepLogoModal}
          />
        </span>

        <span className="main-radio">
          <RadioButton
            label={`Don't need a logo to be featured on my ${productName}`}
            value="no"
            name="existingDesignsExist"
          />
        </span>
      </div>

      {existingDesignsExist === 'yes' && (
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
)

ExistingLogos.propTypes = {
  existingDesignsExist: PropTypes.bool.isRequired,
  existingDesignUploaders: PropTypes.array
}

export default ExistingLogos
