import React from 'react'

import MaterialModal from '@containers/MaterialModal'

import StandardNdaModalContent from './StandardNdaModalContent'

const ClientStandardNdaModal = () => (
  <MaterialModal
    trigger="here"
    value={<StandardNdaModalContent />}
    title="Standard Non-Disclosure Agreement"
    linkClasses="nda-preview-link"
  />
)

export default ClientStandardNdaModal
