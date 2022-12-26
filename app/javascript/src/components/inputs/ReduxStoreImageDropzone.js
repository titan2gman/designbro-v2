import omit from 'lodash/omit'
import join from 'lodash/join'
import last from 'lodash/last'
import toUpper from 'lodash/toUpper'

import PropTypes from 'prop-types'
import Dropzone from 'react-dropzone'
import { connect } from 'react-redux'
import React, { Component } from 'react'

import { actions, Field, Control, Errors } from 'react-redux-form'

import { required } from '@utils/validators'

const getStringWithFileExtensions = (fileExtensions) => {
  const upperCasedFileExtensions = fileExtensions.map(toUpper)

  if (upperCasedFileExtensions.length === 1) {
    return last(upperCasedFileExtensions)
  }

  return join(upperCasedFileExtensions.slice(0, -1), ', ') +
    ' or ' + last(upperCasedFileExtensions)
}

const DeleteLink = ({ onDelete }) =>
  (<span>
    <br />

    <span className="upload-box__remove-link text-underline-hover">
      <span onClick={onDelete}>
        Delete
      </span>
    </span>
  </span>)

const ErrorWrapper = ({ children }) =>
  (<span className="main-input__hint in-pink-500 is-visible">
    {children}
  </span>)

const UploadedFilePreview = ({ value: previewUrl }) =>
  (<div>
    {previewUrl && <div className="upload-box__image"
      style={{ backgroundImage: `url(${previewUrl})` }} />}
  </div>)

UploadedFilePreview.propTypes = {
  value: PropTypes.string
}

const UploadFileBox = ({ fileExtensions, fileType, fileSize, previewUrl, onDelete }) =>
  (<main>
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
  </main>)

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
    'previewUrlModel',
    'fileExtensions',
    'onUploadSuccess',
    'showDeleteLink',
    'fileIdModel',
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
    <main>
      <Dropzone
        style={{}}
        multiple={false}
        onDrop={props.onDrop}
        disabled={props.disabled}
      >
        {({ getRootProps, getInputProps }) => (
          <>
            <div {...getRootProps({ className: 'upload-box' })}>
              <Field model={props.previewUrlModel}>
                {({ value: previewUrl }) =>
                  (<UploadFileBox
                    onDelete={onDelete}
                    previewUrl={previewUrl}
                    fileSize={props.fileSize}
                    fileType={props.fileType}
                    fileExtensions={props.fileExtensions}
                  />)
                }
              </Field>

              <Field model={props.previewUrlModel}>
                {(props) => <UploadedFilePreview {...props} />}
              </Field>

              <Field model={props.fileIdModel}>
                {({ value }) => value && <div
                  className="file-uploaded"
                />}
              </Field>

              <input type="hidden" {...rest} {...getInputProps()}/>
            </div>
            <Control
              type="hidden"
              validators={{ required }}
              model={props.previewUrlModel}
            />
          </>
        )}
      </Dropzone>

      {props.showErrors && <div className="">
        <Field model={props.previewUrlModel}>
          {(props) =>
            (<Errors
              show={showError(props)}
              component={ErrorWrapper}
              messages={{ required: 'Required.' }}
              model={props.previewUrlModel}
            />)
          }
        </Field>
      </div>}
    </main>
  )
}

ReduxStoreImageDropzone.propTypes = {
  onDelete: PropTypes.func,
  fileType: PropTypes.string,
  showErrors: PropTypes.bool,
  onUploadSuccess: PropTypes.func,
  onUpload: PropTypes.func.isRequired,
  fileSize: PropTypes.number.isRequired,
  fileIdModel: PropTypes.string.isRequired,
  previewUrlModel: PropTypes.string.isRequired,
  fileExtensions: PropTypes.arrayOf(PropTypes.string).isRequired
}

ReduxStoreImageDropzone.defaultProps = {
  fileType: 'image', showErrors: true
}

const mapDispatchToProps = (dispatch, props) => {
  const onDrop = (files) => {
    const { onUpload, onUploadSuccess } = props
    const { fileIdModel, previewUrlModel } = props

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

    dispatch(
      actions.change(
        previewUrlModel,
        file.preview
      )
    )

    onUpload(file).then(
      (fsa) => {
        if (fsa.error) {
          dispatch(actions.change(previewUrlModel, null))
          window.alert(fsa.payload.response.errors.file.join('\n'))
        } else {
          dispatch(actions.change(fileIdModel, fsa.payload.data.id))
        }
      }
    ).then(onUploadSuccess)
  }

  return { onDrop }
}

export default connect(null, mapDispatchToProps)(
  ReduxStoreImageDropzone
)
