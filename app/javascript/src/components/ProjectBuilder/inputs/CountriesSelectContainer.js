import React, { Component } from 'react'
import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom'
import countries from 'country-list'

import {
  changeAttributes,
  saveStep
} from '@actions/projectBuilder'

import {
  getProjectBuilderStep,
  getProjectBuilderAttributes
} from '@selectors/projectBuilder'

import SelectMultiple from '@components/inputs/SelectMultiple'

const allCountriesList = countries.getCodes().map((code) => ({
  id: code,
  text: countries.getName(code),
}))

class SelectMultipleContainer extends Component {
  handleAdd = (value) => {
    const { name, attributes, openStep, changeAttributes, saveStep } = this.props
    changeAttributes({ [name]: [...attributes[name], value.id] })
    saveStep(openStep)
  }

  handleDelete = (index) => {
    const { name, attributes, openStep, changeAttributes, saveStep } = this.props
    changeAttributes({
      [name]: [
        ...attributes[name].slice(0, index),
        ...attributes[name].slice(index + 1)
      ]
    })
    saveStep(openStep)
  }

  render () {
    const { attributes, name } = this.props
    const values = attributes[name].map((code) => ({
      id: code,
      text: countries.getName(code)
    }))

    return (
      <div className="bfs-content__info-width">
        <SelectMultiple
          {...this.props}
          values={values}
          onAdd={this.handleAdd}
          onDelete={this.handleDelete}
        />
      </div>
    )
  }
}

const mapStateToProps = (state, { match }) => {
  const stepName = match.params.step
  const openStep = getProjectBuilderStep(state, stepName)
  const attributes = getProjectBuilderAttributes(state)

  return {
    openStep,
    attributes,
    options: allCountriesList,
    placeholder: 'Which countries will your design be aimed at?'
  }
}

export default withRouter(
  connect(
    mapStateToProps, {
      changeAttributes,
      saveStep
    }
  )(SelectMultipleContainer)
)
