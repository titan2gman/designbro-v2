import React, { useState } from 'react'
import moment from 'moment'
import PropTypes from 'prop-types'
import parse from 'html-react-parser'
import _ from 'lodash'
import { letterifyName } from '@utils/user'

const mediaFileTypes = [
  'jpg', 'jpeg', 'gif', 'png'
]

const UserPic = ({ name }) => (
  <div className="conv-message__user-pic">
    <span className="text-truncate text-uppercase">
      {letterifyName(name && name.split(' '))}
    </span>
  </div>
)

UserPic.propTypes = {
  name: PropTypes.string.isRequired
}

const forceDownload = (blob, filename) => {
  const a = document.createElement('a')
  a.download = filename
  a.href = blob
  a.target = '_blank'
  document.body.appendChild(a)
  a.click()
  a.remove()
}

const downloadResource = (url, filename) => {
  fetch(url, {
    headers: new Headers({
      'Origin': location.origin
    }),
    mode: 'cors'
  })
    .then(response => response.blob())
    .then(blob => {
      const blobUrl = window.URL.createObjectURL(blob)
      forceDownload(blobUrl, filename)
    })
    .catch(e => console.error(e))
}

const ChatMessage = ({ createdAt, name, displayName, text, type, messageAttachedFiles, onMessageHover, onThumbClick }) => (
  <div className={type === 'sent' ? 'conv-message__sent' : 'conv-message__received'}>
    <div className="conv-message__header">
      <div className="conv-message__sender-info">
        <UserPic name={name} />
        <span className="conv-message__sender-name">
          {displayName}
        </span>
      </div>
      <div className="conv-message__date">
        {moment(new Date(createdAt)).fromNow()}
      </div>
    </div>
    <div className="conv-message__body">
      {parse(text)}
    </div>
    <div className="conv-message__thumbnail-wrapper">
      {messageAttachedFiles.map(item => (
        <div className="conv-message__thumbnail" key={item.file}>
          {_.includes(mediaFileTypes, item.extension) ? (
            <a className="" href={item.file} download={item.originalFilename} target="_blank">
              <img
                src={item.file}
                // onClick={() => onThumbClick({
                //   isOpen: true,
                //   imageUrl: item.file
                // })}
                onClick={() => downloadResource(item.file, item.originalFilename)}
                onMouseLeave={() => {
                  onMessageHover({
                    show: false
                  })
                }}
                onMouseOver={() => {
                  const convContainerRect = document.getElementById('conversation_container').getBoundingClientRect()
                  const rect = event.target.getBoundingClientRect()
                  const bottom = convContainerRect.height - (rect.bottom - convContainerRect.top)
                  const left = rect.left - convContainerRect.left - 400 - 20
                  onMessageHover({
                    show: true,
                    containerStyle: {
                      left,
                      bottom
                    },
                    imageUrl: item.file
                  })
                }}
              />
            </a>
          ) : (
            <a className="" href={item.file} download={item.originalFilename} target="_blank">
              <div className="conv-message__non-media">
                <span>
                  {item.originalFilename.length > 20 ?
                    `${item.originalFilename.substring(0, 10)}...` :
                    `${item.originalFilename.split('.')[0]}`
                  }
                </span>
                <div className="conv-message__extension">{item.extension}</div>
              </div>
            </a>
          )}
          {/* <div className='conv-message__thumbnail-download'>
            <a className='icon-download right' href={item.file} download={item.originalFilename}/>
          </div> */}
        </div>
      ))}
    </div>
  </div>
)

ChatMessage.propTypes = {
  name: PropTypes.string.isRequired,
  displayName: PropTypes.string.isRequired,
  text: PropTypes.string.isRequired,
  createdAt: PropTypes.string.isRequired
}

const DirectConversationChatMessages = ({ messages, onMessageHover, onThumbClick }) => (
  <div>
    {messages.map((message, index) =>
      <ChatMessage key={index} {...message} onMessageHover={onMessageHover} onThumbClick={onThumbClick}/>
    )}
  </div>
)

DirectConversationChatMessages.propTypes = {
  messages: PropTypes.arrayOf(
    PropTypes.shape(ChatMessage.propTypes)
  )
}

export default DirectConversationChatMessages
