import React from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'

import { uploadTechnicalDrawing } from '@actions/technicalDrawings'

import ImageDropzone from '@components/inputs/ReduxStoreImageDropzone'

const TechnicalDrawingImageDropzone = ({ fileIdModel, previewUrlModel, uploadTechnicalDrawing, onUploadSuccess }) => (
  <ImageDropzone
    fileExtensions={['jpeg', 'png', 'ai', 'eps', 'pdf']}
    previewUrlModel={previewUrlModel}
    onUpload={uploadTechnicalDrawing}
    onUploadSuccess={onUploadSuccess}
    fileType="a technical drawing"
    fileIdModel={fileIdModel}
    showErrors={false}
    fileSize={10}
  />
)

TechnicalDrawingImageDropzone.propTypes = {
  fileIdModel: PropTypes.string.isRequired,
  previewUrlModel: PropTypes.string.isRequired
}

const mapDispatchToProps = {
  uploadTechnicalDrawing
}

export default connect(null, mapDispatchToProps)(
  TechnicalDrawingImageDropzone
)
