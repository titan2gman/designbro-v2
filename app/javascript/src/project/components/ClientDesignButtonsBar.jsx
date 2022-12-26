import React from 'react'
import PropTypes from 'prop-types'

import PreviousVersionsBtn from '@project/containers/PreviousVersionsBtn'

const ClientDesignButtonsBar = ({ triggerVersionsPanel }) => (
  <PreviousVersionsBtn onClick={triggerVersionsPanel} />
)

ClientDesignButtonsBar.propTypes = {
  triggerVersionsPanel: PropTypes.func.isRequired
}

export default ClientDesignButtonsBar
