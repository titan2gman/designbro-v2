import React from 'react'
import PropTypes from 'prop-types'

import PackagingTypeError from '../PackagingTypeError'
import TechnicalDrawingImageDropzone from '@components/inputs/TechnicalDrawingImageDropzone'
import TechnicalDrawingInfoPopup from './TechnicalDrawingInfoPopup'

const PlasticPackPackagingTypeOptions = ({ onFormChange }) => (
  <div>
    <div className="font-22 font-bold m-b-10">
      Plastic pack measurements
    </div>

    <div className="psb-content__title m-b-40">
      Please provide the technical drawing of your pack
    </div>

    <div className="psb-content__info">
      <div className="psb-content__info-part">
        <p className="psb-content__info-part-title">
          Technical drawing

          <TechnicalDrawingInfoPopup />
        </p>

        <div className="psb-content__upload-box">
          <TechnicalDrawingImageDropzone
            onUploadSuccess={onFormChange}
            fileIdModel="forms.newProjectPackagingType.plasticPackMeasurements.technicalDrawingId"
            previewUrlModel="forms.newProjectPackagingType.plasticPackMeasurements.technicalDrawingUrl"
          />
        </div>
      </div>
    </div>

    <PackagingTypeError
      text="Please upload technical drawing."
      model="forms.newProjectPackagingType.plasticPackMeasurements"
    />
  </div>
)

PlasticPackPackagingTypeOptions.propTypes = {
  onFormChange: PropTypes.func
}

export default PlasticPackPackagingTypeOptions
