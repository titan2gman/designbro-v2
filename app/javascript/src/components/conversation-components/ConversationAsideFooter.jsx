import React from 'react'

import MaterialTextarea from '../inputs/MaterialTextarea'

const ConversationAsideFooter = () => (
  <div className="conv-content-aside__footer">
    <div className="divider-line" />
    <div className="conv-leave-message">
      <div className="conv-leave-message__body">
        <div className="main-userpic main-userpic-md conv-leave-message__initials">
          <span className="main-userpic__text-md text-truncate text-uppercase">
            New
          </span>
        </div>
        <div className="conv-leave-message-textarea">
          <MaterialTextarea model="forms.stubs.bbb" label="Start type" placeholder="Tell us more" id="message" type="text" name="message" autoComplete="message" />
        </div>
      </div>
      <div className="conv-leave-message__footer text-right">
        <a href="#" className="main-button main-button--md main-button--black-pink font-12 m-b-5">
          Send
        </a>
      </div>
    </div>
  </div>
)

export default ConversationAsideFooter
