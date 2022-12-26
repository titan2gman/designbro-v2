import React, { useState } from 'react'
import PropTypes from 'prop-types'
import { withRouter } from 'react-router-dom'

import { connect } from 'react-redux'
import { Modal } from 'semantic-ui-react'
import { hideModal } from '@actions/modal'
import MaterialRadio from '@components/inputs/MaterialRadioPlain'
import MaterialTextarea from '@components/inputs/MaterialTextareaPlain'

const EliminateWorkModal = ({ onClose, onConfirm, project, history }) => {
  const [reason, setReason] = useState(null)
  const [eliminateCustomReason, setEliminateCustomReason] = useState(null)

  const handleChange = (name, value) => {
    setReason(value)
    name === 'other' || setEliminateCustomReason(null)
  }

  const handleCustomReasonChange = (name, value) => {
    setEliminateCustomReason(value)
  }

  const isFormInvalid = !reason || (reason === 'other' && !eliminateCustomReason)

  const handleEliminateDesign = () => {
    const eliminationData = {
      eliminateReason: reason,
      eliminateCustomReason: eliminateCustomReason,
    }
    if (!isFormInvalid) {
      onConfirm(eliminationData).then(() => {
        history.push(`/c/projects/${project.id}`)
        onClose()
      })
    }
  }

  return (
    <Modal id="eliminate-work-modal" className="main-modal main-modal--xs" size="small" open onClose={onClose}>
      <div className="modal-primary">
        <div className="modal-primary__header conv-modal-primary-header bg-green-500 in-white">
          <p className="modal-primary__header-title">Confirmation</p>
        </div>
        <div className="modal-primary__body">
          <div className="modal-primary__body-block conv-confirmation-modal-primary-body-block">
            <p className="in-grey-200 font-14">
              Eliminate this work? Please provide the reason for your elimination so we can give this
              feedback to the designer and click confirm. The design will also permanently be removed
              from your project, and the spot will open up again to our pool of designers.
            </p>
            <MaterialRadio
              label="Design is not in line with the briefing / my needs"
              value="not_in_line"
              name="not_in_line"
              checked={reason === 'not_in_line'}
              onChange={handleChange}
            />
            <MaterialRadio
              label="Designer did not communicate back to me"
              value="not_communicate"
              name="not_communicate"
              checked={reason === 'not_communicate'}
              onChange={handleChange}
            />
            <MaterialRadio
              label="Designer did not understand my feedback"
              value="not_understand"
              name="not_understand"
              checked={reason === 'not_understand'}
              onChange={handleChange}
            />
            <MaterialRadio
              label="Just looking for something else"
              value="looking_for_something_else"
              name="looking_for_something_else"
              checked={reason === 'looking_for_something_else'}
              onChange={handleChange}
            />
            <MaterialRadio
              label="Other"
              value="other"
              name="other"
              checked={reason === 'other'}
              onChange={handleChange}
            />
            {(reason === 'other') &&
              <MaterialTextarea
                type="text"
                value={eliminateCustomReason}
                name="eliminate_custom_reason"
                onChange={handleCustomReasonChange}
                error={reason === 'other' && !eliminateCustomReason && 'Required'}
              />
            }

          </div>
        </div>
        <div className="modal-primary__actions conv-modal-primary-actions conv-confirmation-primary-actions align-items-start">
          <button className="main-button-link main-button-link--lg main-button-link--grey-black m-b-10" type="button" onClick={onClose}>
            Cancel
          </button>
          <button
            id="modal-confirm"
            className="main-button-link main-button-link--lg main-button-link--black-pink m-b-10"
            type="button"
            onClick={handleEliminateDesign}
            disabled={isFormInvalid}
          >
            Confirm
            <i className="m-l-20 font-8 icon-arrow-right-long" />
          </button>
        </div>
      </div>
    </Modal>
  )
}

EliminateWorkModal.propTypes = {
  onClose: PropTypes.func.isRequired,
  onConfirm: PropTypes.func.isRequired
}

export default withRouter(connect(null, {
  onClose: hideModal
})(EliminateWorkModal))
