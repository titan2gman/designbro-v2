import React from 'react'
import DirectConversationChatInputBar from '@project/components/DirectConversationChatInputBar'
import DirectConversationChatHeader from '@project/components/DirectConversationChatHeader'
import DirectConversationChatMessages from '@project/containers/DirectConversationChatMessages'
import ConversationRichInput from '@components/conversation-components/rich-input/ConversationRichInput'

const DirectConversationChat = ({ project, design, messages, onMessageSend, closeLink, client, onMessageHover, onThumbClick, user }) => (
  <div className="conv-chat__content">
    <DirectConversationChatHeader
      projectName={project.name}
      designName={design.name}
      designerName={design.designerName}
      clientName={client.firstName}
      closeLink={closeLink}
    />

    <DirectConversationChatMessages messages={messages} onMessageHover={onMessageHover} onThumbClick={onThumbClick}/>

    {(
      project.state === 'completed' ||
      project.state === 'design_stage' && design.state === 'eliminated' ||
      project.state === 'finalist_stage' && ['elimated', 'design_uploaded'].includes(design.state) ||
      project.state === 'review_stage' && ['elimated', 'design_uploaded', 'stationery', 'stationery_uploaded', 'finalist'].includes(design.state) ||
      project.state === 'files_stage' && ['elimated', 'design_uploaded', 'stationery', 'stationery_uploaded', 'finalist'].includes(design.state)
    ) ? (
      <p className="text-center in-grey-500">This project has now ended.</p>
      ) : (
        !design.banned && <ConversationRichInput onMessageSend={onMessageSend} user={user}/>
      )}
  </div>
)

export default DirectConversationChat
