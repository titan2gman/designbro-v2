import React from 'react'
import PropTypes from 'prop-types'
import { Form } from 'react-redux-form'
import { Modal } from 'semantic-ui-react'

import { letterifyName } from '@utils/user'
import { required } from '@utils/validators'

import MaterialTextarea from '@components/inputs/MaterialTextarea'
import MaterialStarRating from '@containers/inputs/MaterialStarRating'

const LeaveReviewModal = ({ onClose: handleClose, onConfirm: handleConfirm, design }) => (
  <Modal
    onClose={handleClose}
    className="main-modal"
    size="large"
    closeOnEscape={false}
    closeOnDimmerClick={false}
    open
  >
    <Form model="forms.review">
      <div className="main-modal__info">
        <div className="main-modal__info-body">
          <div className="text-center p-t-30">
            <div className="main-userpic main-userpic-lg m-b-20">
              <span className="main-userpic__text-lg">
                {letterifyName(design.designerName.split(' '))}
              </span>
            </div>

            <p className="font-24 font-bold in-green-500 m-b-30">
              {design.designerName}
            </p>
          </div>

          <div className="row">
            <div className="col-xs-12 col-sm-6 design-review">
              <div className="text-center p-t-30">
                <p className="font-13 in-grey-400 m-b-20">
                  How was your Designer?
                </p>

                <MaterialStarRating
                  model="forms.review.designerRating"
                  className="rating-stars rating-stars--lg m-b-40"
                />
              </div>

              <MaterialTextarea
                type="text"
                id="designerComment"
                name="designerComment"
                model=".designerComment"
                validators={{ required }}
                errors={{ required: 'Required.' }}
                label={`Describe your experience working with ${design.designerName}`}
              />
            </div>

            <div className="col-xs-12 col-sm-6 overall-review">
              <div className="text-center p-t-30">
                <p className="font-13 in-grey-400 m-b-20">
                  How was your overall experience?
                </p>

                <MaterialStarRating
                  model="forms.review.overallRating"
                  className="rating-stars rating-stars--lg m-b-40"
                />
              </div>

              <MaterialTextarea
                type="text"
                id="overallComment"
                name="overallComment"
                model=".overallComment"
                validators={{ required }}
                errors={{ required: 'Required.' }}
                label="Describe your experience working with DesignBro"
              />
            </div>
          </div>
        </div>

        <div className="main-modal__actions only-confirm">
          <button
            type="submit"
            id="continue-btn"
            onClick={handleConfirm}
            className="main-button-link main-button-link--black-pink main-button-link--lg m-b-10">

            Confirm and continue

            <i className="m-l-20 font-8 icon-arrow-right-long" />
          </button>
        </div>
      </div>
    </Form>
  </Modal>
)

const designerShape = PropTypes.shape({
  designerName: PropTypes.string.isRequired
})

LeaveReviewModal.propTypes = {
  design: designerShape.isRequired,

  onClose: PropTypes.func.isRequired,
  onConfirm: PropTypes.func.isRequired
}

export default LeaveReviewModal
