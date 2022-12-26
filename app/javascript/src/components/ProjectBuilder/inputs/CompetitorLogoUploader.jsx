import React, { Component } from 'react'
import PropTypes from 'prop-types'

import { InputRelatedEntity, TextareaRelatedEntity, StarRating, ImageDropzone } from './index'

const entityName = 'competitors'

const CompetitorLogoUploader = ({ index, errors }) => {
  return (
    <div className="row">
      <div className="col-sm-6 col-md-4 col-xl-3">
        <ImageDropzone
          name={`${entityName}.${index}`}
          fileExtensions={['jpg', 'png']}
          fileSize={2}
          error={errors.previewUrl}
        />
      </div>

      <div className="col-md-5 m-b-20">
        <InputRelatedEntity
          name={`${entityName}.${index}.name`}
          label="Competitor Name"
        />

        <InputRelatedEntity
          name={`${entityName}.${index}.website`}
          label="Competitor Website (optional)"
        />

        <StarRating
          name={`${entityName}.${index}.rate`}
          className="flex"
          label="Rate the design"
        />

        <TextareaRelatedEntity
          name={`${entityName}.${index}.comment`}
          label="Comment (optional)"
        />
      </div>
    </div>
  )
}

CompetitorLogoUploader.propTypes = {
  index: PropTypes.number.isRequired,
}

export default CompetitorLogoUploader
