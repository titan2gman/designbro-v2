import React from 'react'
import PropTypes from 'prop-types'

import MaterialModal from '@containers/MaterialModal'
import TermsModalContent from '@static/signup/TermsModalContent'

const TermsTitle = () => (
  <div>
    <p className="modal-primary__header-title main-modal__info-text">PLATFORM TERMS AND CONDITIONS</p>
    <p className="modal-primary__header-title main-modal__info-text">DesignBro</p>
    <p className="main-modal__info-text">Version/Last update: September 2018</p>
  </div>
)

const TermsModal = ({ linkClasses = null, trigger = 'Terms' }) => (
  <MaterialModal
    trigger={trigger}
    title={<TermsTitle />}
    value={<TermsModalContent />}
    linkClasses={linkClasses}
  />
)

TermsModal.propTypes = {
  linkClasses: PropTypes.string
}

export default TermsModal
