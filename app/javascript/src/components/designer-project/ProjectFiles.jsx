import moment from 'moment'
import isEmpty from 'lodash/isEmpty'
import times from 'lodash/times'
import React, { Component } from 'react'
import { NavLink, Link } from 'react-router-dom'
import PropTypes from 'prop-types'

import Layout from '../../containers/designer-project/Layout'

const UploadedFile = ({
  onDelete,
  file,
  winnerDesign,
  project
}) => (
  <figure className="dpj-file-icon__item file-icon__item">
    <a href={file.url}>
      <div className="file-icon text-center in-white">
        <p className="file-icon__name text-truncate">{file.extension}</p>
        <p className="file-icon__text text-truncate">{Math.round(file.fileSize * 100) / 100} mb</p>
      </div>
    </a>
    <figcaption className="file-icon__details">
      <p className="file-icon__title">{file.filename}</p>
      <p className="file-icon__date in-grey-200 m-b-20">
        {moment().diff(new Date(file.createdAt), 'days')} day
      </p>
      <div className="file-icon__action flex flex-wrap space-between">
        {project.state === 'review_files' && <a
          onClick={onDelete}
          className="file-icon__action-icon icon-trash font-18 cursor-pointer"
        />}

        <a href={file.url} download className="file-icon__action-icon icon-download font-20 cursor-pointer" />

        {project.state === 'review_files' && winnerDesign && (
          <Link
            to={`/d/projects/${project.id}/designs?design_id=${winnerDesign.id}`}
            className="file-icon__action-icon icon-message font-18"
          />
        )}
      </div>
    </figcaption>
  </figure>
)

class ProjectFiles extends Component {
  handleDelete = (id) => () => {
    const { destroySourceFile, match } = this.props

    destroySourceFile(match.params.id, id)
  }

  handleShowModal = () => {
    const { showModal } = this.props

    showModal('SOURCE_FILES_CHECKLIST')
  }

  render () {
    const {
      files,
      winnerDesign,
      project,
      authHeaders
    } = this.props

    return (
      <Layout
        page="files"
      >
        <main>
          <div className="container">
            <div className="dpj-files-header-top">
              <p className="dpj-files-header-top__title in-grey-400 m-b-20">
                Files uploaded
              </p>

              <div className="flex align-center">
                {files.length > 0 && (
                  <a
                    href={`/api/v1/projects/${project.id}/project_source_files.zip?uid=${encodeURIComponent(authHeaders.uid)}&client=${authHeaders.client}&access-token=${authHeaders['access-token']}`}
                    className="main-button-link main-button-link--grey-black font-13 m-r-20"
                    target="_blank"
                  >
                    Download Zip
                    <i className="dpj-files-header-bottom__download-link-icon icon-download" />
                  </a>
                )}

                {project.state !== 'completed' && (
                  <div onClick={this.handleShowModal} className="upload-files main-button main-button--sm main-button--clear-grey cursor-pointer">
                    <button type="button" className="color-inherit cursor-pointer">Upload files</button>
                  </div>
                )}
              </div>

              <div className="divider-line" />
            </div>

            <div className="dpj-file-icon__wrap">
              <div className="dpj-file-icon__list">
                {files.map((file) => (
                  <UploadedFile
                    key={file.id}
                    file={file}
                    onDelete={this.handleDelete(file.id)}
                    winnerDesign={winnerDesign}
                    project={project}
                  />
                ))}
              </div>
            </div>
          </div>
        </main>
      </Layout>
    )
  }
}

export default ProjectFiles
