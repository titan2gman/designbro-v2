import React from 'react'
import PropTypes from 'prop-types'
import forEach from 'lodash/forEach'

const ReplaceDesignBtn = ({ visible, onUploadDesign: handleUpload }) => {
  const handleChange =  (e) => {
    e.preventDefault()
    const files = e.target.files
    forEach(files, (file) => {
      handleUpload(file)
    })
  }

  return (
    <>
      {visible && (
        <div className="upload-files">
          <input id="upload_design" type="file" accept=".jpg,.jpeg,.png" onChange={(e) => handleChange(e)}
            hidden />
          <label htmlFor="upload_design" className="conv-actions__btn-replace-design" style={{ marginRight: '0', marginBottom: '0' }}>
            Replace Design
          </label>
        </div>
      )}
    </>
  )
}

ReplaceDesignBtn.propTypes = {
  visible: PropTypes.bool.isRequired,
  onUploadDesign: PropTypes.func.isRequired
}

export default ReplaceDesignBtn
