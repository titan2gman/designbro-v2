import React, { Component } from 'react'
import _ from 'lodash'
import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom'

import { changeAttributes, saveStep } from '@actions/projectBuilder'

import { getProjectBuilderStep, getProjectBuilderAttributes, getProjectBuilderValidationErrors } from '@selectors/projectBuilder'

import Textarea from '@components/inputs/Textarea'

class TextareaProjectAttribute extends Component {
  handleChange = (event) => {
    const { name, changeAttributes } = this.props
    changeAttributes({ [name]: event.target.value })
  }

  handleBlur = () => {
    const { openStep, saveStep } = this.props
    saveStep(openStep)
  }

  render () {
    return (
      <Textarea
        {...this.props}
        onChange={this.handleChange}
        onBlur={this.handleBlur}
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
  )(TextareaProjectAttribute)
)
