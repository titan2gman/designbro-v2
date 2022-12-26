import React, { Component } from 'react'
import _ from 'lodash'
import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom'

import { changeAttributes, saveStep } from '@actions/projectBuilder'

import { getProjectBuilderStep, getProjectBuilderAttributes } from '@selectors/projectBuilder'

import Select from '@components/inputs/Select'

class SelectContainer extends Component {
  handleChange = (event, { value }) => {
    const { name, openStep, changeAttributes, saveStep } = this.props

    changeAttributes({ [name]: value })

    saveStep(openStep)
  }

  render () {
    const { onChange, ...props } = this.props

    return (
      <Select
        {...props}
        onChange={onChange || this.handleChange}
      />
    )
  }
}

const mapStateToProps = (state, props) => {
  const stepName = props.match.params.step
  const openStep = getProjectBuilderStep(state, stepName)
  const attributes = getProjectBuilderAttributes(state)
  const value = _.get(attributes, props.name)

  return {
    openStep,
    value
  }
}

export default withRouter(
  connect(
    mapStateToProps, {
      changeAttributes,
      saveStep
    }
  )(SelectContainer)
)
