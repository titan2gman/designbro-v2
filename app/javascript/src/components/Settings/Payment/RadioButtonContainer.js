import React, { Component } from 'react'
import { connect } from 'react-redux'
import {
  changeAttributes,
} from '@actions/client'

import RadioButton from '../../inputs/RadioButton'

class RadioButtonContainer extends Component {
  handleChange = (event) => {
    const { name, changeAttributes, onChange } = this.props

    changeAttributes({ [name]: event.target.value })
  }

  render() {
    return (
      <RadioButton
        {...this.props}
        onChange={this.handleChange}
      />
    )
  }
}

export default connect(null, {
  changeAttributes,
})(RadioButtonContainer)
