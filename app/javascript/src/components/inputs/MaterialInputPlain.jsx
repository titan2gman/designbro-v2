import pick from 'lodash/pick'
import isEmpty from 'lodash/isEmpty'

import React, { Component } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

const HintWrapper = ({ text }) => (
  <div className="main-input__hint is-visible in-black">
    {text}
  </div>
)

class MaterialInput extends Component {
  state = {
    focused: false
  }

  handleFocus = () => {
    this.setState({
      focused: true
    })
  }

  handleBlur = () => {
    this.setState({
      focused: false
    })

    if (this.props.onBlur) {
      this.props.onBlur()
    }
  }

  handleChange = (event) => {
    this.props.onChange(this.props.name, event.target.value)
  }

  render () {
    const inputOptions = pick(this.props, ['type', 'id', 'name', 'autoComplete', 'disabled'])
    const { value, error, label, className } = this.props

    return (
      <div
        className={classNames('main-input', className, {
          'is-focused': !!value,
          'is-invalid': !!error
        })}
      >
        <div className="main-input__input-box">
          <input
            className="main-input__input"
            {...inputOptions}
            value={value || ''}
            onChange={this.handleChange}
            onFocus={this.handleFocus}
            onBlur={this.handleBlur}
          />
          <label className="main-input__label" htmlFor={inputOptions.id}>{label}</label>
        </div>

        {error && (
          <div className="main-input__hint in-pink-500">{error}</div>
        )}

        {this.state.focused && <HintWrapper text={this.props.hint} />}

        {this.props.children}
      </div>
    )
  }
}

MaterialInput.propTypes = {
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

export default MaterialInput
