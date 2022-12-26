import React from 'react'
import PropTypes from 'prop-types'

import { AdditionalDocumentUploader } from '../../inputs'

const AdditionalDocuments = ({ additionalDocumentUploaders }) => (
  <div className="bfs-add-document-block">
    <div className="row">
      <div className="col-md-8">
        <p className="font-bold in-grey-400">
          Additional Documents
        </p>

        <p className="bfs-subhint__text">
          Upload any additional documents.

          <br />
          (for instance labelling requirements, back label text, marketing research, etc)
        </p>
      </div>
    </div>

    <div className="bfs-content__upload-box row">
      {additionalDocumentUploaders.map((uploader, index) => (
        <AdditionalDocumentUploader
          key={index}
          index={index}
        />
      ))}
    </div>
  </div>
)

AdditionalDocuments.propTypes = {
  additionalDocumentUploaders: PropTypes.array
}

export default AdditionalDocuments
