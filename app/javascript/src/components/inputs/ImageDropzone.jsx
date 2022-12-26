import omit from 'lodash/omit'
import join from 'lodash/join'
import last from 'lodash/last'
import toUpper from 'lodash/toUpper'

import PropTypes from 'prop-types'
import Dropzone from 'react-dropzone'
import { connect } from 'react-redux'
import React, { Component } from 'react'
import ErrorWrapper from '@components/inputs/Error'

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

const getUrl = (previewUrl) => {
  if (previewUrl.startsWith('blob')) {
    return previewUrl
  }

  const fileName = previewUrl.split('?')[0].split('.')
  const fileExtension = fileName[fileName.length - 1]

  return ['png', 'jpg', 'jpeg'].includes(fileExtension) ? previewUrl : `/${fileExtension}_placeholder.png`
}

const UploadedFilePreview = ({ previewUrl }) => {
  if (!previewUrl) {
    return <div/>
  }

  return (
    <div>
      <div
        className="upload-box__image"
        style={{ backgroundImage: `url(${getUrl(previewUrl)})` }}
      />
    </div>
  )
}

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
        disableClick={props.disabled}
      >
        {({ getRootProps, getInputProps }) => (
          <div {...getRootProps({ className: 'dropzone' })}>
            <div className="upload-box">
              <UploadFileBox
                onDelete={onDelete}
                previewUrl={props.previewUrl}
                fileSize={props.fileSize}
                fileType={props.fileType}
                fileExtensions={props.fileExtensions}
              />

              <UploadedFilePreview previewUrl={props.previewUrl} />

              {props.previewUrl && (
                <div
                  className="file-uploaded"
                />
              )}

              <input type="hidden" {...rest} {...getInputProps()}/>
            </div>
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
  onUploadSuccess: PropTypes.func,
  onUpload: PropTypes.func.isRequired,
  fileSize: PropTypes.number.isRequired,
  fileExtensions: PropTypes.arrayOf(PropTypes.string).isRequired
}

ReduxStoreImageDropzone.defaultProps = {
  fileType: 'image'
}

const mapDispatchToProps = (dispatch, props) => {
  const onDrop = (files) => {
    const { onUpload, onUploadSuccess } = props

    if (!files || !files[0]) {
      return
    }

    const file = files[0]

    const fileName = file.name.split('.')
    const fileExtension = fileName[fileName.length - 1]
    const fileOfWrongTypeIsUploaded = !props.fileExtensions.includes(fileExtension)

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
