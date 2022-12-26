import React from 'react'
import PropTypes from 'prop-types'

import MaterialModal from '@containers/MaterialModal'
import PrivacyPolicyModalContent from '@static/signup/PrivacyPolicyModalContent'

const PrivacyPolicyModal = ({ linkClasses = null }) => (
  <MaterialModal
    trigger="Privacy Policy"
    title={<span className="policy-modal__header">designbro.com Privacy Policy</span>}
    value={<PrivacyPolicyModalContent />}
    linkClasses={linkClasses}
  />
)

PrivacyPolicyModal.propTypes = {
  linkClasses: PropTypes.string
}

export default PrivacyPolicyModal
