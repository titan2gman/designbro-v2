import React, { Component } from 'react'
import PropTypes from 'prop-types'

import ReduxStoreImageDropzone from '@components/inputs/ReduxStoreImageDropzonePlain'
import MaterialTextarea from '@components/inputs/MaterialTextareaPlain'
import ErrorWrapper from '../ErrorWrapper'

class PortfolioUploader extends Component {
  handleInputChange = (name, value) => {
    const { productCategoryId, index, changePortfolioWorkAttribute } = this.props

    changePortfolioWorkAttribute(productCategoryId, index, name, value)
  }

  render() {
    const { index, work, validation, productCategoryId, onUpload, disabled } = this.props

    return (
      <>
        <ReduxStoreImageDropzone
          previewUrl={work.previewUrl || work.url}
          onUpload={onUpload}
          fileExtensions={['jpg', 'png']}
          fileSize={2}
          disabled={disabled}
        />

        {validation.uploadedFileId && (
          <ErrorWrapper>
            {validation.uploadedFileId}
          </ErrorWrapper>
        )}

        <MaterialTextarea
          className="upload-box__description"
          name="description"
          label={!disabled ? 'Tell us about the project' : ''}
          type="text"
          value={work.description}
          disabled={disabled}
          onChange={this.handleInputChange}
          error={validation.description}
        />
      </>
    )
  }
}

PortfolioUploader.propTypes = {
  index: PropTypes.number.isRequired,
  productCategoryId: PropTypes.string.isRequired,
  onUpload: PropTypes.func.isRequired,
  submitFailed: PropTypes.bool.isRequired,
  onUploadSuccess: PropTypes.func,
  onUploadError: PropTypes.func
}

export default PortfolioUploader
