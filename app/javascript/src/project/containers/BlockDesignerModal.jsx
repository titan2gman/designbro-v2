import React, { useState } from 'react'
import { withRouter } from 'react-router-dom'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import { Modal } from 'semantic-ui-react'
import MaterialRadio from '@components/inputs/MaterialRadioPlain'
import MaterialTextarea from '@components/inputs/MaterialTextareaPlain'

import { hideModal } from '@actions/modal'

const BlockDesignerModal = ({ onClose, onConfirm, design, project, history }) => {
  const [reason, setReason] = useState(null)
  const [blockCustomReason, setBlockCustomReason] = useState(null)

  const handleChange = (name, value) => {
    setReason(value)
    name === 'other' || setBlockCustomReason(null)
  }

  const handleCustomReasonChange = (name, value) => {
    setBlockCustomReason(value)
  }

  const isFormInvalid = !reason || (reason === 'other' && !blockCustomReason)

  const handleBlockDesigner = () => {
    const blockData = {
      blockReason: reason,
      blockCustomReason: blockCustomReason,
    }
    if (!isFormInvalid) {
      onConfirm(blockData).then(() => {
        history.push(`/c/projects/${project.id}`)
        onClose()
      })
    }
  }

  return (
    <Modal id="block-designer-modal" className="main-modal main-modal--xs" size="small" open onClose={onClose}>
      <div className="modal-primary">
        <div className="modal-primary__header conv-modal-primary-header bg-green-500 in-white">
          <p className="modal-primary__header-title">Confirmation</p>
        </div>
        <div className="modal-primary__body">
          <div className="modal-primary__body-block conv-confirmation-modal-primary-body-block">
            <p className="in-grey-200 font-14">
              If you block {design.designerName} you will never see them again, even in future projects.
              Please let us know why you want to block the designer and click confirm.
              The design will also permanently be removed from your project,and the spot will open up again to our pool of designers.
            </p>
            <MaterialRadio
              label="The designer's work was disappointing"
              value="disappointing"
              name="disappointing"
              checked={reason === 'disappointing'}
              onChange={handleChange}
            />
            <MaterialRadio
              label="Designer did not communicate well"
              value="not_communicate"
              name="not_communicate"
              checked={reason === 'not_communicate'}
              onChange={handleChange}
            />
            <MaterialRadio
              label="Designer was rude"
              value="was_rude"
              name="was_rude"
              checked={reason === 'was_rude'}
              onChange={handleChange}
            />
            <MaterialRadio
              label="I suspect the designer of plagiarism"
              value="plagiarism"
              name="plagiarism"
              checked={reason === 'plagiarism'}
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
              value={blockCustomReason}
              name="eliminate_custom_reason"
              onChange={handleCustomReasonChange}
              error={reason === 'other' && !blockCustomReason && 'Required'}
            />
            }
          </div>
        </div>
        <div className="modal-primary__actions conv-modal-primary-actions conv-confirmation-primary-actions align-items-start">
          <button className="main-button-link main-button-link--lg main-button-link--grey-black m-b-10" type="button" onClick={onClose}>
            No
          </button>
          <button
            id="modal-confirm"
            className="main-button-link main-button-link--lg main-button-link--black-pink m-b-10"
            type="button"
            onClick={handleBlockDesigner}
            disabled={isFormInvalid}
          >
            Yes
            <i className="m-l-20 font-8 icon-arrow-right-long" />
          </button>
        </div>
      </div>
    </Modal>
  )
}

BlockDesignerModal.propTypes = {
  onClose: PropTypes.func.isRequired,
  onConfirm: PropTypes.func.isRequired
}

export default withRouter(connect(null, {
  onClose: hideModal
})(BlockDesignerModal))
