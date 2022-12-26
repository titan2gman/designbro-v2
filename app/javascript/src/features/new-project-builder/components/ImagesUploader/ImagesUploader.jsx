import React, { useState } from 'react'
import PropTypes from 'prop-types'
import Dropzone from 'react-dropzone'
import cn from 'classnames'

import styles from './ImagesUploader.module.scss'

const getUrl = (previewUrl) => {
  if (previewUrl.startsWith('blob')) {
    return previewUrl
  }

  const fileName = previewUrl.split('?')[0].split('.')
  const fileExtension = fileName[fileName.length - 1]

  return ['png', 'jpg', 'jpeg'].includes(fileExtension) ? previewUrl : `/placeholders/file_type_${fileExtension}.svg`
}

const Thumbnail = ({ id, previewUrl, onSelect, onDestroy }) => {
  const handleSelect = () => {
    onSelect(id)
  }

  const handleDestroy = (event) => {
    event.stopPropagation()
    onDestroy(id)
  }

  return (
    <div
      className={styles.thumbnail}
      style={{ backgroundImage: `url(${getUrl(previewUrl)})` }}
      onClick={handleSelect}
    >
      <div className={cn('icon-cross', styles.deleteDesign)} onClick={handleDestroy} />
    </div>
  )
}

Thumbnail.propTypes = {
  id: PropTypes.number,
  previewUrl: PropTypes.string,
  onSelect: PropTypes.func,
  onDestroy: PropTypes.func
}

const ImagePreview = ({ previewUrl, onDestroy }) => {
  const previewStyle = { backgroundImage: `url(${getUrl(previewUrl)})` }

  return (
    <div
      className={styles.preview}
      style={previewStyle}
    >
      <div className={cn('icon-cross', styles.removeImage)} onClick={onDestroy} />

      <div className={styles.previewIcon} />
      <div className={styles.fileName} />
    </div>
  )
}

ImagePreview.propTypes = {
  previewUrl: PropTypes.string,
  onDestroy: PropTypes.func
}

const ActiveImage = ({
  id,
  previewUrl,
  onUpload,
  onDestroy
}) => {
  const handleDestroy = () => onDestroy(id)

  return previewUrl ? (
    <ImagePreview
      previewUrl={previewUrl}
      onDestroy={handleDestroy}
    />
  ) : (
    <Dropzone
      className={styles.dropzone}
      style={{}}
      multiple={false}
      onDrop={onUpload}
    >
      {({ getRootProps, getInputProps }) => (
        <div {...getRootProps({ className: styles.dropzone })}>
          <div className="upload-icon" />
          <div className="upload-caption">Upload</div>
          <div className="upload-caption-hover">You can drag & drop the file from your computer</div>
          <input {...getInputProps()} />
        </div>
      )}
    </Dropzone>
  )
}

ActiveImage.propTypes = {
  id: PropTypes.number,
  previewUrl: PropTypes.string,
  onUpload: PropTypes.func,
  onDestroy: PropTypes.func
}

const ImageUploader = ({
  activeDesign,
  designs,
  fileExtensions,
  fileSize,
  onChange,
  onUpload,
  setActiveDesignId,
  children
}) => {
  const [validationError, setValidationError] = useState()

  const thumbnails = activeDesign ? designs.filter((exDes) => exDes.id !== activeDesign.id) : designs

  const handleFileUpload = (files) => {
    setValidationError(null)

    if (!files || !files[0]) {
      return
    }

    const file = files[0]
    const fileName = file.name.split('.')
    const fileExtension = fileName[fileName.length - 1]

    const fileOfWrongTypeIsUploaded = !fileExtensions.includes(fileExtension)

    if (fileOfWrongTypeIsUploaded) {
      setValidationError('This file type is not supported.')
      return
    }

    if (file.size > fileSize * 1024 * 1024) {
      setValidationError('This file is too big')
      return
    }

    onUpload(file).then((data) => {
      if (data.error) {
        setValidationError(data.payload.statusText)
        return
      }

      const nextDesigns = [
        ...designs,
        {
          previewUrl: data.payload.previewUrl,
          id: data.payload.entityId
        }
      ]

      onChange(nextDesigns)
      setActiveDesignId(data.payload.entityId)
    })
  }

  const handleThumbnailDestroy = (id) => {
    const nextDesigns = designs.map((exDes) => {
      return id === exDes.id ? { ...exDes, _destroy: true } : exDes
    })

    onChange(nextDesigns)
  }

  const handleActiveDestroy = () => {
    const nextDesigns = designs.map((exDes) => {
      return activeDesign.id === exDes.id ? { ...exDes, _destroy: true } : exDes
    })

    onChange(nextDesigns)
    setActiveDesignId(null)
  }

  const handleSelect = (id) => {
    setActiveDesignId(id)
  }

  const handleAddMoreClick = () => {
    setActiveDesignId(null)
  }

  return (
    <div className={styles.imageUploaderWrapper}>
      <div className={styles.previewWrapper}>
        <ActiveImage
          previewUrl={activeDesign && activeDesign.previewUrl}
          onUpload={handleFileUpload}
          onDestroy={handleActiveDestroy}
        />

        {validationError && (
          <div className={styles.validationError}>
            oops... {validationError}<br />
            Supported file types: {fileExtensions.join(', ')}<br />
            Max file size: {fileSize} MB
          </div>
        )}

        {children}
      </div>

      <div className={styles.thumbnailsWrapper}>
        <div className={styles.thumbnailsInnerWrapper}>
          {thumbnails.map((exDes) => (
            <Thumbnail
              key={exDes.id}
              id={exDes.id}
              previewUrl={exDes.previewUrl}
              onSelect={handleSelect}
              onDestroy={handleThumbnailDestroy}
            />
          ))}
        </div>
      </div>

      <div className={styles.addMoreWrapper}>
        {designs.length < 5 && activeDesign && (
          <div className={styles.addMoreBtn} onClick={handleAddMoreClick}>
            <div className={styles.plus} />
            Add more
          </div>
        )}
      </div>
    </div>
  )
}

ImageUploader.propTypes = {
  designs: PropTypes.arrayOf(PropTypes.object),
  activeDesign: PropTypes.object,
  onUpload: PropTypes.func,
  onChange: PropTypes.func,
  setActiveDesignId: PropTypes.func,
}

export default ImageUploader
