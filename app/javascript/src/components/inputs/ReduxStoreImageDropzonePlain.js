import omit from 'lodash/omit'
import join from 'lodash/join'
import last from 'lodash/last'
import toUpper from 'lodash/toUpper'

import PropTypes from 'prop-types'
import Dropzone from 'react-dropzone'
import { connect } from 'react-redux'
import React, { Component } from 'react'
import ErrorWrapper from '../ErrorWrapper'

const getStringWithFileExtensions = (fileExtensions) => {
  const upperCasedFileExtensions = fileExtensions.map(toUpper)

  if (upperCasedFileExtensions.length === 1) {
    return last(upperCasedFileExtensions)
  }

  return join(upperCasedFileExtensions.slice(0, -1), ', ') +
    ' or ' + last(upperCasedFileExtensions)
}

const DeleteLink = ({ onDelete }) =>(
  <span>
    <br />

    <span className="upload-box__remove-link text-underline-hover">
      <span onClick={onDelete}>
        Delete
      </span>
    </span>
  </span>
)

const UploadedFilePreview = ({ previewUrl }) => (
  <div>
    {previewUrl && (
      <div
        className="upload-box__image"
        style={{ backgroundImage: `url(${previewUrl})` }}
      />
    )}
  </div>
)

UploadedFilePreview.propTypes = {
  value: PropTypes.string
}

const UploadFileBox = ({ fileExtensions, fileType, fileSize, previewUrl, onDelete }) => (
  <main>
    <div role="button" className="upload-box__content">
      <i className="upload-box__icon icon-upload-light" />

      <p className="upload-box__text upload-box__text-primary">
        You can Drag & Drop your
        <br />
        file from computer
      </p>

      <p className="upload-box__text upload-box__text-secondary">
        Upload {fileType}

        <br />
        ({getStringWithFileExtensions(fileExtensions)}, max file size {fileSize}MB)

        {previewUrl && onDelete && <DeleteLink onDelete={onDelete} />}
      </p>
    </div>
  </main>
)

UploadFileBox.propTypes = {
  onDelete: PropTypes.func,
  previewUrl: PropTypes.string,
  fileSize: PropTypes.number.isRequired,
  fileType: PropTypes.string.isRequired,
  fileExtensions: PropTypes.arrayOf(PropTypes.string).isRequired
}

const showError = (props) => !props.focus && !props.retouched && props.submitFailed

const ReduxStoreImageDropzone = (props) => {
  const rest = omit(props, [
    'previewUrl',
    'fileExtensions',
    'onUploadSuccess',
    'showDeleteLink',
    'showErrors',
    'fileType',
    'fileSize',
    'onDelete',
    'onUpload',
    'preview',
    'height',
    'width'
  ])

  let onDelete = null

  if (props.onDelete) {
    onDelete = (e) => {
      e.stopPropagation()
      props.onDelete()
    }
  }

  return (
    <>
      <Dropzone
        style={{}}
        multiple={false}
        onDrop={props.onDrop}
        disabled={props.disabled}
      >
        {({ getRootProps, getInputProps }) => (
          <div {...getRootProps({ className: 'upload-box' })}>
            <UploadFileBox
              onDelete={onDelete}
              previewUrl={props.previewUrl}
              fileSize={props.fileSize}
              fileType={props.fileType}
              fileExtensions={props.fileExtensions}
            />

            <UploadedFilePreview {...props} />

            {props.previewUrl && (
              <div
                className="file-uploaded"
              />
            )}

            <input type="hidden" {...rest} {...getInputProps()}/>
          </div>
        )}
      </Dropzone>

      {props.error && (
        <ErrorWrapper>
          {props.error}
        </ErrorWrapper>
      )}
    </>
  )
}

ReduxStoreImageDropzone.propTypes = {
  onDelete: PropTypes.func,
  fileType: PropTypes.string,
  showErrors: PropTypes.bool,
  onUploadSuccess: PropTypes.func,
  onUpload: PropTypes.func.isRequired,
  fileSize: PropTypes.number.isRequired,
  fileExtensions: PropTypes.arrayOf(PropTypes.string).isRequired
}

ReduxStoreImageDropzone.defaultProps = {
  fileType: 'image', showErrors: true
}

const mapDispatchToProps = (dispatch, props) => {
  const onDrop = (files) => {
    const { onUpload, onUploadSuccess } = props

    if (!files || !files[0]) {
      return
    }

    const file = files[0]

    const fileTypes = {
      png: 'image/png',
      jpg: 'image/jpeg',
      jpeg: 'image/jpeg',
      eps: 'image/x-eps',
      pdf: 'application/pdf',
      ai: 'application/illustrator'
    }

    let fileOfWrongTypeIsUploaded = true
    let fileExtension = ''

    props.fileExtensions.forEach((extension) => {
      if (fileTypes[extension] === file.type) {
        fileOfWrongTypeIsUploaded = false
        fileExtension = extension
      }
    })

    if (fileOfWrongTypeIsUploaded) {
      window.alert('Wrong file format')
      return
    }

    if (file.size > props.fileSize * 1024 * 1024) {
      window.alert('File is too big')
      return
    }

    if (!['png', 'jpg', 'jpeg'].includes(fileExtension)) {
      file.preview = `/${fileExtension}_placeholder.png`
    } else {
      file.preview = URL.createObjectURL(file)
    }

    onUpload(file)
  }

  return { onDrop }
}

export default connect(null, mapDispatchToProps)(
  ReduxStoreImageDropzone
)
