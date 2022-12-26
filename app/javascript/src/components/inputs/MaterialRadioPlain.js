import pick from 'lodash/pick'

import React, { Component } from 'react'
import PropTypes from 'prop-types'

class MaterialRadio extends Component {
  handleChange = (event) => {
    this.props.onChange(this.props.name, event.target.value)
  }

  render () {
    const inputOptions = pick(this.props, ['name', 'value', 'disabled'])

    return (
      <div>
        <label className="main-radio m-b-0" id={this.props.id}>
          <input
            className="main-radio__input"
            type="radio"
            onChange={this.handleChange}
            checked={this.props.checked}
            {...inputOptions}
          />
          <span className="main-radio__icon m-r-10" />
          <span className="main-radio__text">
            {this.props.label}
          </span>
        </label>

        {this.props.children}
      </div>
    )
  }
}

MaterialRadio.propTypes = {
  id: PropTypes.string,
  name: PropTypes.string,
  error: PropTypes.string,
  onChange: PropTypes.func,
  updateOn: PropTypes.string,
  autoComplete: PropTypes.string,
  label: PropTypes.oneOfType([
    PropTypes.string.isRequired,
    PropTypes.object.isRequired
  ])
}

export default MaterialRadio
