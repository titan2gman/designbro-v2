import omit from 'lodash/omit'
import find from 'lodash/find'
import without from 'lodash/without'
import includes from 'lodash/includes'

import PropTypes from 'prop-types'
import Dropzone from 'react-dropzone'
import React, { Component } from 'react'

import { cutAt } from '@utils/stringProcessor'

const ALLOWED_FILE_EXTENSIONS = [
  'png', 'jpg', 'pdf', 'ai',
  'tiff', 'eps', 'psd', 'psb',
  'ppt', 'pptx', 'doc', 'docx',
  'svg', 'indd', 'ico', 'xd', 'mp4'
]

const isAllowedForUploading = (fileExtension) => (
  includes(ALLOWED_FILE_EXTENSIONS, fileExtension)
)

class SourceFilesDropzone extends Component {
  state = { files: [] }

  onDrop = (files) => {
    const { onUpload: handleUpload, showWrongFileFormatModal } = this.props

    if (!files || !files[0]) return

    const containsInvalidFiles = find(files, (file) => {
      const extension = file.name.split('.').pop()
      return !isAllowedForUploading(extension)
    })

    if (containsInvalidFiles) {
      return showWrongFileFormatModal()
    }

    this.setState({ files: files })

    files.forEach((file) => {
      handleUpload(file).then(() => {
        this.setState({ files: without(
          this.state.files, file
        ) })
      })
    })
  }

  render () {
    const rest = omit(this.props, 'onUpload', 'showWrongFileFormatModal')

    return (
      <>
        {this.state.files.map((file, index) => (
          <figure className="file-icon__item conv-popup-file-icon__item" key={index}>
            <div className="file-icon file-icon--loading text-center in-white" />
            <figcaption className="file-icon__details">
              <p className="file-icon__title">{cutAt(file.name, 10)}</p>
            </figcaption>
          </figure>
        ))}

        <div className="text-center">
          <Dropzone multiple onDrop={this.onDrop} style={{}} disabled={this.props.disabled}>
            {({ getRootProps, getInputProps }) => (
              <div {...getRootProps()}>
                <button type="button" className="main-button-link in-grey-200 conv-popup__upload-box m-b-20 text-center">
                  <div className="icon-upload-light font-40" />

                  <div className="conv-popup__upload-box--text inline-block m-l-15">
                    Drag and Drop
                    <br />
                    or Upload your files
                  </div>
                </button>
                <input type="hidden" {...rest} {...getInputProps()}/>
              </div>
            )}
          </Dropzone>
        </div>
      </>
    )
  }
}

SourceFilesDropzone.propTypes = ['onUpload', 'showWrongFileFormatModal'].reduce(
  (propTypes, value) => ({ ...propTypes, [value]: PropTypes.func.isRequired }), {}
)

export default SourceFilesDropzone
