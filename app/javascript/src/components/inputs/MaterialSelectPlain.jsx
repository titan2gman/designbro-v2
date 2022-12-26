import React, { Component } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import { Select } from 'semantic-ui-react'

const HintWrapper = ({ text }) => (
  <div className="main-input__hint is-visible in-black">
    {text}
  </div>
)

class MaterialSelect extends Component {
  handleChange = (e, { value }) => {
    this.props.onChange(this.props.name, value)
  }

  render () {
    const { name, placeholder, value, options, error, label, className } = this.props

    return (
      <div
        className={classNames('main-input main-dropdown', className, {
          'is-invalid': !!error
        })}
      >
        <Select
          options={options}
          value={value}
          onChange={this.handleChange}
          name={name}
          placeholder={placeholder}
        />

        {error && (
          <div className="main-input__hint in-pink-500">{error}</div>
        )}
      </div>
    )
  }
}

MaterialSelect.propTypes = {
  hint: PropTypes.string,
  extra: PropTypes.string,
  error: PropTypes.string,
  onChange: PropTypes.func,
  autoComplete: PropTypes.string,
  id: PropTypes.string,
  type: PropTypes.string.isRequired,
  name: PropTypes.string.isRequired,
  label: PropTypes.string.isRequired
}

export default MaterialSelect
