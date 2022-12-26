import PropTypes from 'prop-types'
import classNames from 'classnames'
import forEach from 'lodash/forEach'
import React, { Component } from 'react'

class UploadButton extends Component {
  handleChange (e) {
    const { onUpload } = this.props

    e.preventDefault()
    const files = e.target.files

    forEach(files, (file) => {
      onUpload(file)
    })
  }

  render () {
    const { className, children } = this.props

    return (
      <div className={classNames('upload-files', className)}>
        <input type="file" accept=".jpg,.jpeg,.png" className="upload-files__btn" onChange={(e) => this.handleChange(e)} />
        <button type="button" className="color-inherit cursor-pointer">{children}</button>
      </div>
    )
  }
}

UploadButton.propTypes = {
  children: PropTypes.node
}

export default UploadButton
