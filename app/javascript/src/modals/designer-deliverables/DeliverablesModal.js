import React from 'react'
import { connect } from 'react-redux'
import { Modal } from 'semantic-ui-react'

import { hideModal } from '@actions/modal'

const DeliverablesFile = ({ productKey }) => {
  const imageUrl = `/deliverables/${productKey}.pdf`
  
  return (
    <iframe
      width="100%"
      className="modal__frame"
      src={imageUrl}
      type="application/pdf"
    />
  )
}

const DeliverablesModal = ({ hideModal, productKey }) => (
  <Modal id="designer-deliverables-modal" className="main-modal" size="large" open onClose={hideModal}>
    <div className="modal-primary">
      <DeliverablesFile productKey={productKey}/>
    </div>
  </Modal>
)

export default connect(null, { hideModal })(DeliverablesModal)
