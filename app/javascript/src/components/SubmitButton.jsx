import React from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

const SubmitButton = ({ text, icon, colorClass }) => (
  <button type="submit" className={classNames('sign-in__form-action main-button main-button--lg', colorClass)}>
    <span className="font-16">{text}</span>{icon && <i className={classNames('m-l-20 font-8 icon', icon)} />}
  </button>
)

SubmitButton.propTypes = {
  text: PropTypes.string.isRequired,
  colorClass: PropTypes.string,
  icon: PropTypes.string
}

export default SubmitButton
