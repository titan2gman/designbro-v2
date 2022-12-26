import React from 'react'
import PropTypes from 'prop-types'
import { Link } from 'react-router-dom'

const DirectConversationChatHeader = ({ designName, projectName, clientName, designerName, closeLink }) => (
  <div className="conv-chat__header">
    <p className="text-truncate in-grey-820 font-11" style={{ marginBottom: '5px' }}>
      {designerName} <span className="in-grey-200">for</span> {projectName}
    </p>

    <p className="text-truncate in-grey-200 font-10" style={{ marginBottom: '5px' }}>
      Project by {clientName}
    </p>
  </div>
)

DirectConversationChatHeader.propTypes = {
  designName: PropTypes.string.isRequired,
  projectName: PropTypes.string.isRequired,
  clientName: PropTypes.string.isRequired,
}

export default DirectConversationChatHeader
