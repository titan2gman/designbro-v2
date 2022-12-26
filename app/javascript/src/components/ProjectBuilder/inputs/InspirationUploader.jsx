import React from 'react'
import PropTypes from 'prop-types'

import { TextareaRelatedEntity, ImageDropzone } from './index'

const entityName = 'inspirations'

const InspirationUploader = ({ index, errors }) => (
  <div className="col-sm-6 col-md-4 col-xl-3">
    <ImageDropzone
      name={`${entityName}.${index}`}
      fileExtensions={['jpg', 'png']}
      error={errors.previewUrl}
      fileSize={2}
    />

    <TextareaRelatedEntity
      name={`${entityName}.${index}.comment`}
      label="Comment (optional)"
    />
  </div>
)

InspirationUploader.propTypes = {
  index: PropTypes.number.isRequired,
}

export default InspirationUploader
