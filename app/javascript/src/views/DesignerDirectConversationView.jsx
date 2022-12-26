import React, { Component } from 'react'
import { compose } from 'redux'
import { connect } from 'react-redux'

import { requireDesignerAuthentication } from '../authentication'

import { loadProject } from '@actions/projects'
import { loadDesign, loadVersions } from '@actions/designs'
import { loadMessages, messageReceived } from '@actions/directConversation'
import handleErrors from '@utils/errors'

import cable from '@utils/cable'

import Conversation from '../containers/designer-project/Conversation'

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
    loadProject,
    loadDesign,
    loadVersions,
    loadMessages,
    messageReceived,
    handleErrors
  }),
  hasData
)

export default compose(
  composedHasData,
  requireDesignerAuthentication
)(Conversation)
