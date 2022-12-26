import React, { Component } from 'react'
import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom'
import {
  changeAttributes,
} from '@actions/projectBuilder'

import {
  getProjectBuilderStep,
  getProjectBuilderAttributes
} from '@selectors/projectBuilder'

import RadioButton from '../../inputs/RadioButton'

class RadioButtonContainer extends Component {
  handleChange = (event) => {
    const { name, changeAttributes, onChange } = this.props

    changeAttributes({ [name]: event.target.value })
    onChange && onChange()
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

const mapStateToProps = (state, { name, value, checked }) => {
  const attributes = getProjectBuilderAttributes(state)

  return {
    attributes,
    checked: checked || attributes[name] === value,
  }
}

export default withRouter(connect(mapStateToProps, {
  changeAttributes,
})(RadioButtonContainer))
