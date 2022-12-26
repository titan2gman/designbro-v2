import React, { Component } from 'react'
import PropTypes from 'prop-types'

import ReduxStoreImageDropzone from '@components/inputs/ReduxStoreImageDropzonePlain'
import styles from './FeaturedImageUploader.module.scss'

const FeaturedImageUploader = ({ url, uploadedFileId, upload, destroy }) => {
  return (
    <div className={styles.wrapper}>
      <ReduxStoreImageDropzone
        previewUrl={url}
        onDelete={destroy(uploadedFileId)}
        onUpload={upload(uploadedFileId)}
        fileExtensions={['jpg']}
        fileSize={2}
      />
    </div>
  )
}

FeaturedImageUploader.propTypes = {
  uploadedFileId: PropTypes.string,
  upload: PropTypes.func.isRequired,
  destroy: PropTypes.func.isRequired,
  changeEntityAttribute: PropTypes.func.isRequired,
  updateProjectFinishAttributes: PropTypes.func.isRequired
}

export default FeaturedImageUploader
