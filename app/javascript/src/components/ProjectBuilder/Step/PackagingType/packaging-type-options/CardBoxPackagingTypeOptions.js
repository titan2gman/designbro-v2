import React from 'react'
import PropTypes from 'prop-types'
import { Form } from 'react-redux-form'

import MaterialInput from '@components/inputs/MaterialInput'
import PackagingTypeError from '../PackagingTypeError'
import TechnicalDrawingImageDropzone from '@components/inputs/TechnicalDrawingImageDropzone'
import TechnicalDrawingInfoPopup from './TechnicalDrawingInfoPopup'

const CardBoxPackagingTypeOptions = ({ onFormChange }) => (
  <div>
    <div className="font-22 font-bold m-b-10">
      Cardboard Box measurements
    </div>

    <div className="psb-content__title m-b-40">
      Please give us the size of the front, side
      and top, or upload a technical drawing
    </div>

    <div className="psb-content__info">
      <div className="psb-content__info-part">
        <div className="psb-content__info-part-title psb-content__info-part-title--left">
          Cardboard Box size
        </div>

        <div className="psb-content__info-part-left-cont">
          <Form model="forms.newProjectPackagingType.cardBoxMeasurements">
            <MaterialInput
              type="text"
              model=".frontWidth"
              onBlur={onFormChange}
              id="card-box-front-width"
              name="card-box-front-width"
              label="Front (width) cm or inches"
            />

            <MaterialInput
              type="text"
              model=".frontHeight"
              onBlur={onFormChange}
              id="card-box-front-height"
              name="card-box-front-height"
              label="Front (height) cm or inches"
            />

            <MaterialInput
              type="text"
              model=".sideDepth"
              onBlur={onFormChange}
              id="card-box-side-depth"
              name="card-box-side-depth"
              label="Side (depth) cm or inches"
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
            fileIdModel="forms.newProjectPackagingType.cardBoxMeasurements.technicalDrawingId"
            previewUrlModel="forms.newProjectPackagingType.cardBoxMeasurements.technicalDrawingUrl"
          />
        </div>
      </div>
    </div>

    <PackagingTypeError
      model="forms.newProjectPackagingType.cardBoxMeasurements"
      text="Please give us the size or upload technical drawing."
    />
  </div>
)

CardBoxPackagingTypeOptions.propTypes = {
  onFormChange: PropTypes.func
}

export default CardBoxPackagingTypeOptions
