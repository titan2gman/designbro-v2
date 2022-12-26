import React from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import ErrorWrapper from '../Error'
import { Select } from 'semantic-ui-react'

const SelectComponent = ({
  name,
  options,
  value,
  disabled,
  placeholder,
  error,
  className,
  children,
  onChange
}) => (
  <div
    className={classNames('main-input main-dropdown', className, {
      'is-invalid': !!error
    })}
  >
    <Select
      options={options}
      value={value}

      onChange={onChange}
      name={name}
      placeholder={placeholder}
      disabled={disabled}
    />

    {error && <ErrorWrapper>{error}</ErrorWrapper>}

    {children}
  </div>
)

SelectComponent.propTypes = {
  value: PropTypes.string,
  disabled: PropTypes.bool,
  className: PropTypes.string,
  error: PropTypes.string,
  onChange: PropTypes.func.isRequired
}

export default SelectComponent
