import React from 'react'
import PropTypes from 'prop-types'

import { Form } from 'react-redux-form'

import MaterialInput from '@components/inputs/MaterialInput'
import PackagingTypeError from '../PackagingTypeError'
import TechnicalDrawingImageDropzone from '@components/inputs/TechnicalDrawingImageDropzone'
import TechnicalDrawingInfoPopup from './TechnicalDrawingInfoPopup'

const CanPackagingTypeOptions = ({ onFormChange }) => (
  <div>
    <div className="font-22 font-bold m-b-10">
      Can measurements
    </div>

    <div className="psb-content__title m-b-40">
      Please give us the measurements of the
      can, or upload a technical drawing
    </div>

    <div className="psb-content__info">
      <div className="psb-content__info-part">
        <div className="psb-content__info-part-title psb-content__info-part-title--left">
          Measurements of the can
        </div>

        <div className="psb-content__info-part-left-cont">
          <Form model="forms.newProjectPackagingType.canMeasurements">
            <MaterialInput
              type="text"
              id="can-height"
              model=".height"
              name="can-height"
              onBlur={onFormChange}
              label="Height (cm or inches)"
            />

            <MaterialInput
              type="text"
              id="can-diameter"
              model=".diameter"
              name="can-diameter"
              onBlur={onFormChange}
              label="Diameter (cm or inches)"
            />

            <MaterialInput
              type="text"
              id="can-volume"
              model=".volume"
              name="can-volume"
              onBlur={onFormChange}
              label="Volume (ml or ounces)"
            />
          </Form>
        </div>
      </div>

      <div className="psb-content__info-part psb-content__info-part-right-cont">
        <p className="psb-content__info-part-hint hidden-sm-down">or</p>

        <p className="psb-content__info-part-title">
          Technical drawing

          <TechnicalDrawingInfoPopup />
        </p>

        <div className="psb-content__upload-box">
          <TechnicalDrawingImageDropzone
            onUploadSuccess={onFormChange}
            fileIdModel="forms.newProjectPackagingType.canMeasurements.technicalDrawingId"
            previewUrlModel="forms.newProjectPackagingType.canMeasurements.technicalDrawingUrl"
          />
        </div>
      </div>
    </div>

    <PackagingTypeError
      model="forms.newProjectPackagingType.canMeasurements"
      text="Please give us the size or upload technical drawing."
    />
  </div>
)

CanPackagingTypeOptions.propTypes = {
  onFormChange: PropTypes.func
}

export default CanPackagingTypeOptions
