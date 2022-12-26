import React from 'react'
import PropTypes from 'prop-types'
import { Form } from 'react-redux-form'

import MaterialInput from '@components/inputs/MaterialInput'
import PackagingTypeError from '../PackagingTypeError'
import TechnicalDrawingImageDropzone from '@components/inputs/TechnicalDrawingImageDropzone'
import TechnicalDrawingInfoPopup from './TechnicalDrawingInfoPopup'

const LabelPackagingTypeOptions = ({ onFormChange }) => (
  <div>
    <div className="font-22 font-bold m-b-10">
      Label measurements
    </div>

    <div className="psb-content__title m-b-40">
      Please upload a technical drawing of the label (or
      photo and size of the printable area / label size)
    </div>

    <div className="psb-content__info">
      <div className="psb-content__info-part">
        <div className="psb-content__info-part-title psb-content__info-part-title--left">
          Photo and size of the printable area / label size)
        </div>

        <div className="psb-content__info-part-left-cont">
          <Form model="forms.newProjectPackagingType.labelMeasurements">
            <MaterialInput
              type="text"
              id="label-width"
              name="label-width"
              model=".labelWidth"
              onBlur={onFormChange}
              label="Label Width (cm or inches)"
            />

            <MaterialInput
              type="text"
              id="label-height"
              name="label-height"
              model=".labelHeight"
              onBlur={onFormChange}
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
            fileIdModel="forms.newProjectPackagingType.labelMeasurements.technicalDrawingId"
            previewUrlModel="forms.newProjectPackagingType.labelMeasurements.technicalDrawingUrl"
          />
        </div>
      </div>
    </div>

    <PackagingTypeError
      model="forms.newProjectPackagingType.labelMeasurements"
      text="Please give us the size or upload technical drawing."
    />
  </div>
)

LabelPackagingTypeOptions.propTypes = {
  onFormChange: PropTypes.func
}

export default LabelPackagingTypeOptions
