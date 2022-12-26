import React from 'react'
import PropTypes from 'prop-types'

const RadioButton = ({ label, name, value, disabled, checked, children, onChange }) => {
  return (
    <div>
      <label className="main-radio m-b-0">
        <input
          className="main-radio__input"
          type="radio"
          name={name}
          value={value}
          disabled={disabled}
          checked={checked}
          onChange={onChange}
        />
        <span className="main-radio__icon m-r-10" />
        <span className="main-radio__text">
          {label}
        </span>
      </label>

      {children}
    </div>
  )
}

RadioButton.propTypes = {
  name: PropTypes.string,
  onChange: PropTypes.func,
  label: PropTypes.string.isRequired,
}

export default RadioButton
