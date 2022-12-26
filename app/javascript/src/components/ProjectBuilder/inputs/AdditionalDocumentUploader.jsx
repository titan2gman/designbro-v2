import React from 'react'
import PropTypes from 'prop-types'

import { TextareaRelatedEntity, ImageDropzone } from './index'

const entityName = 'projectAdditionalDocuments'

const AdditionalDocumentUploader = ({ index }) => (
  <div className="col-sm-6 col-md-4 col-xl-3">
    <ImageDropzone
      name={`${entityName}.${index}`}
      fileExtensions={['jpg', 'jpeg', 'png', 'pdf', 'docx', 'doc', 'pptx', 'ppt', 'sketch', 'ai', 'xd', 'indd', 'psd', 'eps', 'txt', 'rtf']}
      fileSize={25}
      fileType="document"
    />

    <TextareaRelatedEntity
      name={`${entityName}.${index}.comment`}
      label="Comment (optional)"
    />
  </div>
)

AdditionalDocumentUploader.propTypes = {
  index: PropTypes.number.isRequired,
}

export default AdditionalDocumentUploader
