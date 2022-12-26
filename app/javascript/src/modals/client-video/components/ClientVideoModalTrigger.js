import React from 'react'
import PropTypes from 'prop-types'

const ClientVideoModalTriggerWhite = ({ onClick: handleClick }) => (
  <button className="main-header__cta main-button-link main-button--md in-white hidden-sm-down" onClick={handleClick}>
    How it works
  </button>
)

ClientVideoModalTriggerWhite.propTypes = {
  onClick: PropTypes.func.isRequired
}

const ClientVideoModalTriggerBlack = ({ onClick: handleClick }) => (
  <div className="cursor-pointer home-steps__link-text" onClick={handleClick}>
    Find out more

    <i className="home-steps__link-icon icon icon-play-circle m-l-20 font-40 align-middle" />
  </div>
)

ClientVideoModalTriggerBlack.propTypes = {
  onClick: PropTypes.func.isRequired
}

export default {
  White: ClientVideoModalTriggerWhite,
  Black: ClientVideoModalTriggerBlack
}
