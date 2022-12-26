import React from 'react'
import PropTypes from 'prop-types'

import { TextareaRelatedEntity, ImageDropzone } from './index'

const entityName = 'existingDesigns'

const ExistingDesignUploader = ({ index, errors }) => (
  <div className="col-sm-6 col-md-4 col-xl-3">
    <ImageDropzone
      name={`${entityName}.${index}`}
      fileExtensions={['jpg', 'jpeg', 'png', 'ai', 'eps', 'pdf', 'psd']}
      error={errors.previewUrl}
      fileSize={10}
    />

    <TextareaRelatedEntity
      name={`${entityName}.${index}.comment`}
      label="Comment (optional)"
    />
  </div>
)

ExistingDesignUploader.propTypes = {
  index: PropTypes.number.isRequired,
}

export default ExistingDesignUploader
