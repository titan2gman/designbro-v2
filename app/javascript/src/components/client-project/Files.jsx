import moment from 'moment'

import isEmpty from 'lodash/isEmpty'

import React, { Component, Fragment } from 'react'
import PropTypes from 'prop-types'
import { Link } from 'react-router-dom'

import { letterifyName } from '@utils/user'

import UserPic from '@components/ProjectCardUserPic'

const UploadedFile = ({
  file,
  project,
  winnerDesign
}) => (
  <figure className="dpj-file-icon__item file-icon__item">
    <a href={file.url}>
      <div className="file-icon text-center in-white">
        <p className="file-icon__name text-truncate">{file.extension}</p>
        <p className="file-icon__text text-truncate">{Math.round(file.fileSize)} mb</p>
      </div>
    </a>
    <figcaption className="file-icon__details">
      <p className="file-icon__title">{file.filename}</p>
      <p className="file-icon__date in-grey-200 m-b-20">
        {moment().diff(new Date(file.createdAt), 'days')} {moment().diff(new Date(file.createdAt), 'days') > 1 ? 'days' : 'day'}
      </p>
      <div className="file-icon__action flex flex-wrap space-between">
        <a href={file.url} download className="file-icon__action-icon icon-download font-20 cursor-pointer" />
        <Link to={`/c/projects/${project.id}?design_id=${winnerDesign.id}`} className="file-icon__action-icon icon-message font-18" />
      </div>
    </figcaption>
  </figure>
)

class Files extends Component {
  componentDidUpdate (prevProps) {
    const { canLeaveReview } = this.props

    if (!prevProps.canLeaveReview && canLeaveReview) {
      this.review()
    }
  }

  review = () => {
    const { winnerDesign, project, showModal } = this.props

    showModal('LEAVE_REVIEW', {
      design: winnerDesign, project
    })
  }

  approve = () => {
    const { project, showModal, hideModal, approveFiles } = this.props

    showModal('APPROVE_FILES', {
      onConfirm: () => {
        approveFiles(project.id)
        hideModal()
      }
    })
  }

  render() {
    const {
      files,
      project,
      winnerDesign,
      canLeaveReview,
      authHeaders
    } = this.props

    return (
      <Fragment>
        {isEmpty(files) && <div className="dpj-content-empty container text-center">
          <img src="/empty_page.png" className="dpj-content-empty__img m-b-30" alt="empty" />
          <p className="dpj-content-empty__text">No files yet</p>
        </div>}

        {!isEmpty(files) && (
          <div className="dpj-content__uploaded container">
            <div className="dpj-files-header-top m-b-25">
              <div className="flex align-center in-grey-400 m-b-15">
                <div className="main-userpic main-userpic-sm m-r-10">
                  {winnerDesign && <UserPic name={letterifyName(winnerDesign.designerName.split(' '))} />}
                </div>
                {winnerDesign && <a className="text-underline font-14 in-grey-500 m-r-30 cursor-pointer">
                  {winnerDesign.designerName}
                </a>}
                <span className="font-14 font-bold">files uploaded</span>
              </div>

              <div className="flex align-center">
                {files.length > 0 && (
                  <a
                    href={`/api/v1/projects/${project.id}/project_source_files.zip?uid=${encodeURIComponent(authHeaders.uid)}&client=${authHeaders.client}&access-token=${authHeaders['access-token']}`}
                    className="main-button-link main-button-link--grey-black font-13 m-b-20 m-r-20"
                    target="_blank"
                  >
                    Download Zip
                    <i className="dpj-files-header-bottom__download-link-icon icon-download" />
                  </a>
                )}

                {project.state === 'review_files' && <button
                  className="main-button main-button--md main-button--clear-black m-b-15"
                  onClick={this.approve} type="button" id="approve-files">

                  Approve Files
                </button>}

                {canLeaveReview && project.state === 'completed' &&
                  <button
                    type="button"
                    onClick={this.review}
                    id="review-designer"
                    className="main-button main-button--md main-button--clear-black m-b-15">

                    Review Designer
                  </button>
                }
              </div>

              <div className="divider-line" />
            </div>

            <div className="dpj-file-icon__wrap">
              <div className="dpj-file-icon__list">
                {files.map((file) => (<UploadedFile
                  winnerDesign={winnerDesign}
                  key={file.id} file={file}
                  project={project}
                />))}
              </div>
            </div>
          </div>
        )}
      </Fragment>
    )
  }
}

Files.propTypes = {
  canLeaveReview: PropTypes.bool.isRequired
}

export default Files
