import React from 'react'
import { connect } from 'react-redux'
import ContentEditable from 'react-contenteditable'

const ProjectExistingLogos = ({ existingLogos, project, authHeaders }) => (
  <div className="brief-section" id="existing-design">
    <p className="brief-section__title">
      Existing {project.projectType === 'logo' ? 'logo' : 'design'}
    </p>

    {project.sourceFilesShared && (
      <p>
        <a
          href={`/api/v1/projects/${project.id}/project_existing_designs.zip?uid=${encodeURIComponent(authHeaders.uid)}&client=${authHeaders.client}&access-token=${authHeaders['access-token']}`}
          className="main-button-link main-button-link--grey-black font-13 m-b-20 m-r-20"
          target="_blank"
        >
          Download Zip
          <i className="dpj-files-header-bottom__download-link-icon icon-download" />
        </a>
      </p>
    )}

    {existingLogos.map((existingLogo) => (
      <div key={existingLogo.id}>
        <div className="row m-b-30">
          <div className="brief__photo-big col-xs-12 col-lg-3">
            {['png', 'jpg', 'jpeg'].includes(existingLogo.extension) ? (
              <img src={existingLogo.url} alt="existing logo" />
            ) : (
              <figure className="file-icon__item m-r-30">
                <a href={`${existingLogo.url}`} download>
                  <div className="file-icon text-center in-white">
                    <p className="file-icon__name text-ellipsis">
                      {existingLogo.extension}
                    </p>
                    <p className="file-icon__text text-ellipsis">
                      {Math.round(existingLogo.fileSize * 100) / 100} mb
                    </p>
                  </div>
                </a>
              </figure>
            )}
          </div>
        </div>

        {existingLogo.comment && (
          <span>
            <p className="brief__title--sm">Comment</p>
            <p className="brief__comment-text">
              <ContentEditable html={existingLogo.comment} disabled />
            </p>
          </span>
        )}
      </div>
    ))}
  </div>
)

const mapStateToProps = ({ authHeaders }) => ({
  authHeaders
})

export default connect(mapStateToProps)(ProjectExistingLogos)
