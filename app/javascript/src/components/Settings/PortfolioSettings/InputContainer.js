import React, { Component } from 'react'
import { connect } from 'react-redux'

import {
  changeProfileAttribute,
  savePortfolioSettings
} from '@actions/designer'

import Textarea from '@components/inputs/Textarea'

class InputContainer extends Component {
  handleChange = (event) => {
    const { name, changeProfileAttribute } = this.props
    changeProfileAttribute(name, event.target.value)
  }

  handleBlur = () => {
    const { savePortfolioSettings } = this.props
    savePortfolioSettings()
  }

  render () {
    const { onChange, onBlur, ...props } = this.props

    return (
      <Textarea
        {...props}
        onChange={this.handleChange}
        onBlur={this.handleBlur}
      />
    )
  }
}

export default connect(null, {
  changeProfileAttribute,
  savePortfolioSettings
})(InputContainer)
