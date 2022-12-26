import React, { Component } from 'react'
import { connect } from 'react-redux'

import {
  uploadProfileImage,
  destroyProfileImage,
} from '@actions/designer'

import ImageDropzone from '@components/inputs/ImageDropzone'

class ImageDropzoneContainer extends Component {
  render () {
    const { name, uploadProfileImage, destroyProfileImage } = this.props

    return (
      <ImageDropzone
        {...this.props}
        onUpload={uploadProfileImage(name)}
        onDelete={destroyProfileImage(name)}
      />
    )
  }
}

export default connect(null, {
  uploadProfileImage,
  destroyProfileImage
})(ImageDropzoneContainer)
