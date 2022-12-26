import React from 'react'
import { cutAt } from '@utils/stringProcessor'
import { getAgeInDays } from '@utils/dateTime'

const UploadedFile = ({ project, doc }) => (
  <figure className="file-icon__item m-r-30">
    <a href={`${doc.url}`} download>
      <div className="file-icon text-center in-white">
        <p className="file-icon__name text-ellipsis">
          {doc.extension}
        </p>
        <p className="file-icon__text text-ellipsis">
          {Math.round(doc.fileSize * 100) / 100} mb
        </p>
      </div>
    </a>
    <figcaption className="file-icon__details">
      <p className="file-icon__title">
        {cutAt(doc.filename, 14)}
      </p>
      <p className="file-icon__date in-grey-200 m-b-20">
        {getAgeInDays(project.createdAt)}
      </p>
      <div className="file-icon__action flex flex-wrap space-between m-b-10">
        <a
          href={`${doc.url}`}
          download
          className="file-icon__action-icon"
        >
          <i className="icon-download font-20 align-middle m-r-10" />
          <span className="font-12">Download</span>
        </a>
      </div>
      {doc.comment && <div>
        <p className="brief__title--sm m-b-5">Comment</p>
        <p className="brief__comment-text brief__comment-text--sm">
          {doc.comment}
        </p>
      </div>}
    </figcaption>
  </figure>
)

export default ({ project, additionalDocuments }) => (
  <div className="brief-section">
    <p className="brief-section__title">Additional documents</p>
    <div className="row m-b-30">
      {additionalDocuments.map((doc) => (
        <UploadedFile key={doc.id} doc={doc} project={project} />
      ))}
    </div>
  </div>
)
