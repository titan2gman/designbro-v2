import isEmpty from 'lodash/isEmpty'

import React from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import useForm from 'react-hook-form'

import FormButtonWrapper from '@components/FormButtonWrapper'
import FormButton from '@components/FormButton'

import { cutAt } from '@utils/stringProcessor'

import SourceFilesDropzone from '@containers/inputs/SourceFilesDropzone'

const UploadedFile = ({ file }) => (
  <figure className="dpj-file-icon__item file-icon__item">
    <a href={file.url}>
      <div className="file-icon text-center in-white">
        <p className="file-icon__name text-truncate">
          {file.extension}
        </p>

        <p className="file-icon__text text-truncate">
          {Math.round(file.fileSize)} MB
        </p>
      </div>
    </a>

    <figcaption className="file-icon__details">
      <p className="file-icon__title">
        {cutAt(file.filename, 10)}.{file.extension}
      </p>
    </figcaption>
  </figure>
)

UploadedFile.propTypes = {
  file: PropTypes.shape({
    fileSize: PropTypes.number.isRequired,
    filename: PropTypes.string.isRequired,
    extension: PropTypes.string.isRequired
  }).isRequired
}

const UploadedFiles = ({ files }) => (
  <div>
    {files.map((file) => (
      <UploadedFile
        file={file}
        key={file.id}
      />
    ))}
  </div>
)

UploadedFiles.propTypes = {
  files: PropTypes.arrayOf(PropTypes.shape({
    fileSize: PropTypes.number.isRequired,
    filename: PropTypes.string.isRequired,
    extension: PropTypes.string.isRequired
  }))
}

const uploadButtonClassName = (noFilesUploaded) => (
  classNames('main-button-link main-button-link--lg m-b-10',
    noFilesUploaded ? 'main-button-link--disabled' : 'main-button-link'
  )
)

const UploadFilesForm = ({ projectId, canContinue, files, upload, onSubmit }) => {
  const { handleSubmit } = useForm()

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <UploadedFiles files={files} />

      <SourceFilesDropzone onUpload={(file) => upload(projectId, file) } />

      <FormButtonWrapper>
        <FormButton
          type="submit"
          className={classNames({ active: canContinue })}
          disabled={!canContinue}
        >
          Upload files &#8594;
        </FormButton>
      </FormButtonWrapper>
    </form>
  )
}

UploadFilesForm.propTypes = {
  files: PropTypes.arrayOf(PropTypes.shape({
    fileSize: PropTypes.number.isRequired,
    filename: PropTypes.string.isRequired,
    extension: PropTypes.string.isRequired
  })),

  upload: PropTypes.func.isRequired,
}

export default UploadFilesForm
