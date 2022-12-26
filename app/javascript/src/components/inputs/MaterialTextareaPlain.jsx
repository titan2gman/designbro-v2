import pick from 'lodash/pick'
import isEmpty from 'lodash/isEmpty'

import React, { Component } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import Textarea from 'react-textarea-autosize'

const HintWrapper = ({ text }) => (
  <div className="main-input__hint is-visible in-black">
    {text}
  </div>
)

class MaterialTextarea extends Component {
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
    const inputOptions = pick(this.props, ['type', 'name', 'maxRows', 'autoComplete', 'disabled', 'maxLength'])
    const { value, error, label, className, showErrors, hint } = this.props

    return (
      <div className={classNames('main-input', className, { 'is-focused': !!value, 'is-invalid': !!error })}>
        <div className="main-input__input-box">
          <Textarea
            className="main-input__textarea"
            {...inputOptions}
            value={value || ''}
            onChange={this.handleChange}
            onFocus={this.handleFocus}
            onBlur={this.handleBlur}
          />

          <label className="main-input__label" htmlFor={this.props.id}>{label}</label>
        </div>

        {error && (
          <div className="main-input__hint in-pink-500">{error}</div>
        )}

        {this.state.focused && hint && <HintWrapper text={hint} />}
      </div>
    )
  }
}

MaterialTextarea.propTypes = {
  type: PropTypes.string.isRequired,
  name: PropTypes.string.isRequired,
  label: PropTypes.string.isRequired,
  extra: PropTypes.string,
  autoComplete: PropTypes.string,
  error: PropTypes.string,
  onChange: PropTypes.func
}

export default MaterialTextarea
