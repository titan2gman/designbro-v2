import React, { Component } from 'react'
import _ from 'lodash'
import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom'

import { changeAttributes, saveStep } from '@actions/projectBuilder'

import { getProjectBuilderStep, getProjectBuilderAttributes, getProjectBuilderValidationErrors } from '@selectors/projectBuilder'

import Input from '@components/inputs/Input'

class InputContainer extends Component {
  handleChange = (event) => {
    const { name, changeAttributes } = this.props
    changeAttributes({ [name]: event.target.value })
  }

  handleBlur = () => {
    const { openStep, saveStep } = this.props
    saveStep(openStep)
  }

  render () {
    const { onChange, onBlur, ...props } = this.props
    return (
      <Input
        {...props}
        onChange={onChange || this.handleChange}
        onBlur={onBlur || this.handleBlur}
      />
    )
  }
}

const mapStateToProps = (state, props) => {
  const stepName = props.match.params.step
  const openStep = getProjectBuilderStep(state, stepName)
  const attributes = getProjectBuilderAttributes(state)
  const errors = getProjectBuilderValidationErrors(state)
  const value = _.get(attributes, props.name)

  return {
    openStep,
    value,
    error: errors[props.name]
  }
}

export default withRouter(
  connect(
    mapStateToProps, {
      changeAttributes,
      saveStep
    }
  )(InputContainer)
)
