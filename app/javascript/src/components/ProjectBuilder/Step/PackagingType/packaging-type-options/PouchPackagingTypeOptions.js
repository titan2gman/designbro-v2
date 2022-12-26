import React from 'react'
import PropTypes from 'prop-types'
import { Form } from 'react-redux-form'

import MaterialInput from '@components/inputs/MaterialInput'
import PackagingTypeError from '../PackagingTypeError'
import TechnicalDrawingImageDropzone from '@components/inputs/TechnicalDrawingImageDropzone'
import TechnicalDrawingInfoPopup from './TechnicalDrawingInfoPopup'

const PouchPackagingTypeOptions = ({ onFormChange }) => (
  <div>
    <div className="font-22 font-bold m-b-10">
      Pouch measurements
    </div>

    <div className="psb-content__title m-b-40">
      Please provide the technical drawing of your pouch
    </div>

    <div className="psb-content__info">
      <div className="psb-content__info-part">
        <div className="psb-content__info-part-title psb-content__info-part-title--left">
          Pouch size
        </div>

        <div className="psb-content__info-part-left-cont">
          <Form model="forms.newProjectPackagingType.pouchMeasurements">
            <MaterialInput
              type="text"
              model=".width"
              id="pouch-width"
              name="pouch-width"
              onBlur={onFormChange}
              label="Width (cm or inches)"
            />

            <MaterialInput
              type="text"
              model=".height"
              id="pouch-height"
              name="pouch-height"
              onBlur={onFormChange}
              label="Height (cm or inches)"
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
            fileIdModel="forms.newProjectPackagingType.pouchMeasurements.technicalDrawingId"
            previewUrlModel="forms.newProjectPackagingType.pouchMeasurements.technicalDrawingUrl"
          />
        </div>
      </div>
    </div>

    <PackagingTypeError
      model="forms.newProjectPackagingType.pouchMeasurements"
      text="Please give us the size or upload technical drawing."
    />
  </div>
)

PouchPackagingTypeOptions.propTypes = {
  onFormChange: PropTypes.func
}

export default PouchPackagingTypeOptions
