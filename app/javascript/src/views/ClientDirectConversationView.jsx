import React, { Component } from 'react'
import { compose } from 'redux'
import { connect } from 'react-redux'

import { requireClientAuthentication } from '../authentication'

import { loadProject } from '@actions/projects'
import {
  loadMessages,
  messageReceived
} from '@actions/directConversation'

import {
  loadDesign,
  loadVersions,
} from '@actions/designs'

import cable from '@utils/cable'

import handleErrors from '@utils/errors'

import Conversation from '../containers/client-project/Conversation'

const hasData = (View) => {
  return class HasData extends Component {
    componentWillMount () {
      const {
        loadProject,
        loadDesign,
        loadVersions,
        loadMessages,
        messageReceived,
        projectId,
        designId
      } = this.props

      loadDesign(projectId, designId).then((fsa) => {
        if (fsa.error) {
          handleErrors(null)(fsa)
        } else {
          loadVersions(projectId, designId)
          loadMessages(projectId, designId)
          this.ws = cable.subscriptions.create({
            channel: 'DirectConversationChannel',
            design: designId
          }, {
            received: messageReceived
          })
        }
      })
    }

    componentWillUnmount () {
      if (this.ws) {
        this.ws.unsubscribe()
      }
    }

    render () {
      return <View {...this.props} />
    }
  }
}

const composedHasData = compose(
  connect(null, {
    loadDesign,
    loadProject,
    loadVersions,
    loadMessages,
    messageReceived,
  }),
  hasData
)

export default compose(
  composedHasData,
  requireClientAuthentication
)(Conversation)
