import React, { Component } from 'react'
import { connect } from 'react-redux'
import { languages } from '@constants/languages'

import {
  changeProfileAttribute,
  savePortfolioSettings
} from '@actions/designer'

import SelectMultiple from '@components/inputs/SelectMultiple'

const allLanguagesList = languages.map((l) => ({
  id: l.code,
  text: l.name
}))

class SelectMultipleContainer extends Component {
  handleAdd = (value) => {
    const { name, attributes, changeProfileAttribute, savePortfolioSettings } = this.props

    changeProfileAttribute(name, [...attributes[name], value.id])
    savePortfolioSettings()
  }

  handleDelete = (index) => {
    const { name, attributes, changeProfileAttribute, savePortfolioSettings } = this.props

    changeProfileAttribute(name, [...attributes[name].slice(0, index), ...attributes[name].slice(index + 1)])
    savePortfolioSettings()
  }

  render () {
    const { attributes, name } = this.props
    const values = allLanguagesList.filter((l) => attributes[name].includes(l.id))


    return (
      <SelectMultiple
        {...this.props}
        values={values}
        onAdd={this.handleAdd}
        onDelete={this.handleDelete}
      />
    )
  }
}

const mapStateToProps = (state) => {
  const attributes = state.designer.profileAttributes

  return {
    attributes,
    options: allLanguagesList
  }
}

export default connect(mapStateToProps, {
  changeProfileAttribute,
  savePortfolioSettings
})(SelectMultipleContainer)
