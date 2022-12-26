import React from 'react'
import PropTypes from 'prop-types'

import { Form } from 'react-redux-form'

import MaterialInput from '@components/inputs/MaterialInput'
import PackagingTypeError from '../PackagingTypeError'
import TechnicalDrawingImageDropzone from '@components/inputs/TechnicalDrawingImageDropzone'
import TechnicalDrawingInfoPopup from './TechnicalDrawingInfoPopup'

const BottlePackagingTypeOptions = ({ onFormChange }) => (
  <div>
    <div className="font-22 font-bold m-b-10">
      Bottle measurements
    </div>

    <div className="psb-content__title m-b-40">
      Please upload a technical drawing of the bottle (or photo
      and size of the printable area / label size)
    </div>

    <div className="psb-content__info">
      <div className="psb-content__info-part">
        <div className="psb-content__info-part-title psb-content__info-part-title--left">
          Photo and size of the printable area / label size)
        </div>

        <div className="psb-content__info-part-left-cont">
          <Form model="forms.newProjectPackagingType.bottleMeasurements">
            <MaterialInput
              type="text"
              model=".labelWidth"
              onBlur={onFormChange}
              id="bottle-label-width"
              name="bottle-label-width"
              label="Label Width (cm or inches)"
            />

            <MaterialInput
              type="text"
              model=".labelHeight"
              onBlur={onFormChange}
              id="bottle-label-height"
              name="bottle-label-height"
              label="Label Height (cm or inches)"
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
            fileIdModel="forms.newProjectPackagingType.bottleMeasurements.technicalDrawingId"
            previewUrlModel="forms.newProjectPackagingType.bottleMeasurements.technicalDrawingUrl"
          />
        </div>
      </div>
    </div>

    <PackagingTypeError
      model="forms.newProjectPackagingType.bottleMeasurements"
      text="Please give us the size or upload technical drawing."
    />
  </div>
)

BottlePackagingTypeOptions.propTypes = {
  onFormChange: PropTypes.func
}

export default BottlePackagingTypeOptions
