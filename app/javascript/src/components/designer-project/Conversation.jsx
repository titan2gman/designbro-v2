import React, { Component } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import { withRouter, Link } from 'react-router-dom'
import { Modal } from 'semantic-ui-react'

import DesignInfo from '@project/containers/DesignInfo'
import DesignCurrentWork from '@project/containers/DesignCurrentWork'
import DesignVersionsPanel from '@project/containers/DesignVersionsPanel'
import DirectConversationChat from '@project/containers/DirectConversationChat'
import DesignButtonsBar from '@project/components/design-buttons-bar/DesignButtonsBar'
import ReplaceDesignBtn from '@project/containers/design-buttons-bar/ReplaceDesignBtn'

class DesignerDirectConversationPage extends Component {
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
    },
    convDesignContent: {
      width: null,
      height: null
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
    this.setState({ showPanel: !this.state.showPanel })
    if (this.props.project.state === 'completed') {
      return
    }
    if (!this.state.showPanel) {
      designVersionsPanel.classList.add('popover__transition')
      designVersionsPanel.clientWidth
      designVersionsPanel.classList.remove('popover__hidden')
    } else {
      designVersionsPanel.classList.add('popover__transition')
      designVersionsPanel.classList.add('popover__hidden')
    }
  }

  handleShowModal = () => {
    const { projectId } = this.props.match.params
    const { showModal, history } = this.props

    showModal('SOURCE_FILES_CHECKLIST', {
      callback: () => history.push(`/d/projects/${projectId}/files`)
    })
  }

  handleUploadVersion = (file) => {
    if (!file) return

    if (file.type !== 'image/jpeg' && file.type !== 'image/png') {
      window.alert('Wrong file format! Only JPG or PNG!')
      return
    }

    if (file.size > 2 * 1024 * 1024) {
      window.alert('File is too big! 2MB or less!')
      return
    }

    const { projectId, designId } = this.props

    this.props.uploadVersion(projectId, designId, file).then((response) => {
      if (!response.error) {
        this.props.loadVersions(projectId, designId)
      }
    })
  }

  handleRestore = (value) => {
    const { projectId, designId } = this.props

    return this.props.restoreVersion(projectId, designId, value)
  }

  handleMessageSend = (value) => {
    const { projectId, designId } = this.props

    this.props.sendMessage(projectId, designId, value),
    this.props.reset()
  }

  render () {
    const {
      project,
      spot,
      design,
      showChat,
      uploading,
      closeLink,
      onClose,
      onThumbClick,
      user
    } = this.props

    const {
      showPanel
    } = this.state

    return (
      <Modal
        open={true}
        className="conv-modal"
        closeOnDimmerClick={true}
        onClose={onClose}
      >
        <div className="conv-container" id="conversation_container">
          <div className="conv-wrapper">
            <div className="conv__designer-actions-panel">
              <a
                onClick={onClose}
                className="conv__close-btn"
              />
            </div>
            <div className="conv-content">
              <div className="conv-design__container">
                <div className="conv-design__content">
                  <DesignCurrentWork />
                </div>
                <div className="conv-bottom-panel">
                  {project.state !== 'completed' && !this.state.showPanel && (
                    <DesignButtonsBar
                      triggerVersionsPanel={this.triggerVersionsPanel}
                      onShowModal={this.handleShowModal}
                      design={design}
                      spot={spot}
                    />
                  )}
                  {!uploading && (
                    <DesignInfo onRateDesign={this.handleRateDesign} project={project}/>
                  )}
                  {project.state !== 'completed' && !this.state.showPanel && (
                    <ReplaceDesignBtn onUploadDesign={this.handleUploadVersion} />
                  )}
                </div>
              </div>
              <div className="conv-chat__container">
                {showChat &&
                  <DirectConversationChat onMessageSend={this.handleMessageSend} onMessageHover={this.handleMessageThumbPopover} onThumbClick={onThumbClick} user={user}/>
                }
              </div>
            </div>
            <div className="design-versions__panel popover__hidden">
              <DesignVersionsPanel
                triggerVersionsPanel={this.triggerVersionsPanel}
                onRestore={this.handleRestore}
                onPreviousDesignHover={this.handleDesignVersionThumbPopover}
              />
            </div>
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

DesignerDirectConversationPage.propTypes = {
  spot: PropTypes.object,
  design: PropTypes.object,
  showChat: PropTypes.bool.isRequired,
  uploading: PropTypes.bool.isRequired,
  showModal: PropTypes.func.isRequired,
  uploadVersion: PropTypes.func.isRequired,
}

export default withRouter(DesignerDirectConversationPage)
