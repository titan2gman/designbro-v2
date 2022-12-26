import React from 'react'
import parse from 'html-react-parser'

const DetectMessage = ({ show, onClose, containerStyle, titleStyle, title, content }) => (
  <div className="detect-msg__container" style={{ ...containerStyle, visibility: show ? 'visible' : 'hidden' }}>
    <div className="detect-msg__content">
      <span className="detect-msg__title" style={titleStyle}>{parse(title)}</span>
      <br/>
      {parse(content)}
    </div>
    <div className="detect-msg__footer" onClick={onClose}>
      <div className="detect-msg__footer-content">
        <span>Got it! Continue</span>
        <i className="icon-arrow-right"/>
      </div>
    </div>
  </div>
)

export default DetectMessage
