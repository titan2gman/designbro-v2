import classNames from 'classnames'
import React, { Component } from 'react'
import { Popup } from 'semantic-ui-react'

const TechnicalDrawingInfoPopupTrigger = (
  <i className={classNames(
    'm-l-10',
    'font-20',
    'align-middle',
    'cursor-pointer',
    'icon-info-circle',
    'popup-icon-trigon'
  )} />
)

const TechnicalDrawingInfoPopupContent = (onGotItClick) => (
  <div className="main-modal bg-green-500 in-white">
    <div className="psb-popup-tech-draw">
      <div className="psb-popup-tech-draw__body">
        <div className="no-shrink">
          <img
            alt="techdrow"
            src="/techdrow_illustration.png"
            srcSet="/techdrow_illustration_2x.png 2x"
          />
        </div>
        <div className="psb-popup-tech-draw__info">
          <p className="psb-popup-tech-draw__info-text">
            Technical drawings are a representation of the shape of your selected pack.
            Typically they are in PDF format, and can easily be requested with your producer.
          </p>
        </div>
      </div>
      <div className="main-modal__actions flex-end" onClick={onGotItClick}>
        <span className={classNames(
          'in-white',
          'cursor-pointer',
          'main-button-link',
          'main-button-link--lg'
        )} type="button">

          Got it

          <i className="m-l-20 font-8 icon-arrow-right-long" />
        </span>
      </div>
    </div>
  </div>
)

class TechnicalDrawingInfoPopup extends Component {
  state = {
    isOpen: false
  }

  open = () => {
    this.setState({
      isOpen: true
    })
  }

  close = () => {
    this.setState({
      isOpen: false
    })
  }

  render () {
    return (
      <Popup
        open={this.state.isOpen}
        on="click" positioning="bottom center"
        onOpen={this.open} onClose={this.close}
        style={{ zIndex: 2 }} className="psb-popup"
        trigger={TechnicalDrawingInfoPopupTrigger}
        content={TechnicalDrawingInfoPopupContent(this.close)}
      />
    )
  }
}

export default TechnicalDrawingInfoPopup
