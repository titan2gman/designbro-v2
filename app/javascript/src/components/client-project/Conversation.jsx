import React, { Component, useRef } from 'react'
import PropTypes from 'prop-types'
import { withRouter } from 'react-router-dom'
import { Modal } from 'semantic-ui-react'

import DesignInfo from '@project/containers/DesignInfo'
import DesignCurrentWork from '@project/containers/DesignCurrentWork'
import DesignVersionsPanel from '@project/containers/DesignVersionsPanel'
import ClientDesignActions from '@project/containers/ClientDesignActions'
import ClientDesignButtonsBar from '@project/components/ClientDesignButtonsBar'
import DirectConversationChat from '@project/containers/DirectConversationChat'
import DesignChangeViewModeBar from '@project/containers/DesignChangeViewModeBar'
import HeaderLight from '@containers/HeaderLight'

class Conversation extends Component {
  state = {
    showPanel: false,
    messageThumbPopoverProps: {
      show: false,
      containerStyle: {},
      imageUrl: ''
    },
    designVersionThumbPopoverProps: {
      show: false,
      containerStyle: {},
      imageUrl: ''
    }
  }

  componentDidMount() {
    const designVersionThumbPopover = document.getElementsByClassName('design-version__thumb-popover')[0]
    const msgThumbPopover = document.getElementsByClassName('message__thumb-popover')[0]
    const designVersionsPanel = document.getElementsByClassName('design-versions__panel')[0]

    designVersionThumbPopover.addEventListener('transitionend', this.removeTransitionFromDesignVersionPopover, false)
    msgThumbPopover.addEventListener('transitionend', this.removeTransitionFromMsgPopover, false)
    designVersionsPanel.addEventListener('transitionend', this.removeTransitionFromDesignVersionsPanel, false)
  }

  componentWillUnmount() {
    const designVersionThumbPopover = document.getElementsByClassName('design-version__thumb-popover')[0]
    const msgThumbPopover = document.getElementsByClassName('message__thumb-popover')[0]
    const designVersionsPanel = document.getElementsByClassName('design-versions__panel')[0]

    designVersionThumbPopover.removeEventListener('transitionend', this.removeTransitionFromDesignVersionPopover)
    msgThumbPopover.removeEventListener('transitionend', this.removeTransitionFromMsgPopover)
    designVersionsPanel.removeEventListener('transitionend', this.removeTransitionFromDesignVersionsPanel)

    this.props.cleanDirectConversationMessages()
  }

  removeTransitionFromDesignVersionPopover = () => {
    document.getElementsByClassName('design-version__thumb-popover')[0].classList.remove('popover__transition')
  }
  removeTransitionFromMsgPopover = () => {
    document.getElementsByClassName('message__thumb-popover')[0].classList.remove('popover__transition')
  }
  removeTransitionFromDesignVersionsPanel = () => {
    document.getElementsByClassName('design-versions__panel')[0].classList.remove('popover__transition')
  }

  handleMessageThumbPopover = (_messageThumbPopoverProps) => {
    const msgThumbPopover = document.getElementsByClassName('message__thumb-popover')[0]
    this.setState({ messageThumbPopoverProps: _messageThumbPopoverProps })
    if (_messageThumbPopoverProps.show) {
      msgThumbPopover.classList.add('popover__transition')
      msgThumbPopover.clientWidth
      msgThumbPopover.classList.remove('popover__hidden')
    } else {
      // msgThumbPopover.classList.add('popover__transition')
      msgThumbPopover.classList.add('popover__hidden')
      msgThumbPopover.classList.remove('popover__transition')
    }
  }

  handleDesignVersionThumbPopover = (_designVersionThumbPopoverProps) => {
    const designVersionThumbPopover = document.getElementsByClassName('design-version__thumb-popover')[0]
    this.setState({ designVersionThumbPopoverProps: _designVersionThumbPopoverProps })
    if (_designVersionThumbPopoverProps.show) {
      designVersionThumbPopover.classList.add('popover__transition')
      designVersionThumbPopover.clientWidth
      designVersionThumbPopover.classList.remove('popover__hidden')
    } else {
      // designVersionThumbPopover.classList.add('popover__transition')
      designVersionThumbPopover.classList.add('popover__hidden')
      designVersionThumbPopover.classList.remove('popover__transition')
    }
  }

  triggerVersionsPanel = () => {
    const designVersionsPanel = document.getElementsByClassName('design-versions__panel')[0]
    const showPanelPrev = this.state.showPanel
    this.setState({ showPanel: !showPanelPrev })
    if (!showPanelPrev) {
      designVersionsPanel.classList.add('popover__transition')
      designVersionsPanel.clientWidth
      designVersionsPanel.classList.remove('popover__hidden')
    } else {
      designVersionsPanel.classList.add('popover__transition')
      designVersionsPanel.clientWidth
      designVersionsPanel.classList.add('popover__hidden')
    }
  }

  handleRateDesign = (value) => {
    const { projectId, designId } = this.props

    this.props.rateDesign(projectId, designId, value)
  }

  handleSelectFinalist = () => {
    const { projectId, designId } = this.props

    return this.props.selectFinalist(projectId, designId)
  }

  handleSelectWinner = () => {
    const { designId } = this.props

    return this.props.selectWinner(designId)
  }

  handleApproveStationery = () => {
    const { projectId, designId } = this.props

    return this.props.approveStationery(projectId, designId)
  }

  handleMessageSend = (value) => {
    const { projectId, designId } = this.props

    this.props.sendMessage(projectId, designId, value)
    this.props.reset()
  }

  render () {
    const {
      project,
      viewMode,
      showChat,
      canSelectWinner,
      canSelectFinalists,
      onClose,
      onThumbClick,
      user,
      isOpen
    } = this.props

    return (
      <Modal
        open={isOpen}
        closeOnDimmerClick={true}
        className="conv-modal"
        onClose={onClose}
      >
        <div className="conv-container" id="conversation_container">
          <ClientDesignActions
            project={project}
            canSelectFinalists={canSelectFinalists}
            canSelectWinner={canSelectWinner}
            onApproveStationery={this.handleApproveStationery}
            onSelectFinalist={this.handleSelectFinalist}
            onSelectWinner={this.handleSelectWinner}
            onClose={onClose}
          />
          <div className="conv-content">
            <div className="conv-design__container">
              <div id="conv_design_content" className="conv-design__content">
                <DesignCurrentWork project={project}/>
              </div>
              <div className="conv-bottom-panel">
                <div className="conv-bottom__buttons-bar-left">
                  {!this.state.showPanel && (
                    <ClientDesignButtonsBar triggerVersionsPanel={this.triggerVersionsPanel} />
                  )}
                </div>
                <div className="">
                  <DesignInfo onRateDesign={this.handleRateDesign} project={project}/>
                </div>
              </div>
            </div>
            <div className="conv-chat__container">
              {showChat &&
                <DirectConversationChat onMessageSend={this.handleMessageSend} onMessageHover={this.handleMessageThumbPopover} onThumbClick={onThumbClick} user={user}/>
              }
            </div>
          </div>
          <div className="design-versions__panel popover__hidden">
            <DesignVersionsPanel triggerVersionsPanel={this.triggerVersionsPanel} onPreviousDesignHover={this.handleDesignVersionThumbPopover}/>
          </div>
        </div>
        <div className="message__thumb-popover popover__hidden" style={this.state.messageThumbPopoverProps.containerStyle}>
          <img src={this.state.messageThumbPopoverProps.imageUrl}/>
        </div>
        <div className="design-version__thumb-popover popover__hidden" style={this.state.designVersionThumbPopoverProps.containerStyle}>
          <img src={this.state.designVersionThumbPopoverProps.imageUrl}/>
        </div>
      </Modal>
    )
  }
}

Conversation.propTypes = {
  project: PropTypes.object.isRequired,
  viewMode: PropTypes.string.isRequired,
  canSelectWinner: PropTypes.bool.isRequired,
  canSelectFinalists: PropTypes.bool.isRequired,

  rateDesign: PropTypes.func.isRequired,
  sendMessage: PropTypes.func.isRequired,
  blockDesigner: PropTypes.func.isRequired,
  selectFinalist: PropTypes.func.isRequired,
  selectWinner: PropTypes.func.isRequired,
  eliminateDesign: PropTypes.func.isRequired,
  approveStationery: PropTypes.func.isRequired,
}

export default withRouter(Conversation)
