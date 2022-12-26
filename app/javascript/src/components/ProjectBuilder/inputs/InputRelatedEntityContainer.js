import React, { Component } from 'react'
import _ from 'lodash'
import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom'

import { saveStep } from '@actions/projectBuilder'
import { changeEntityAttribute } from '@actions/brandRelatedEntities'

import { getProjectBuilderStep, getProjectBuilderAttributes } from '@selectors/projectBuilder'

import Input from '@components/inputs/Input'

class InputRelatedEntity extends Component {
  handleChange = (event) => {
    const [entityName, index, name] = this.props.name.split('.')
    this.props.changeEntityAttribute(entityName, index, name, event.target.value)
  }

  handleBlur = () => {
    const { openStep, saveStep } = this.props
    saveStep(openStep)
  }

  render () {
    return (
      <Input
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
  const value = _.get(attributes, props.name.split('.'))

  return {
    openStep,
    value
  }
}

export default withRouter(
  connect(
    mapStateToProps, {
      changeEntityAttribute,
      saveStep
    }
  )(InputRelatedEntity)
)
