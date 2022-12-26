import React, { Component } from 'react'
import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom'

import { changeAttributes, saveStep } from '@actions/projectBuilder'
import { upgradePackagingPriceSelector } from '@selectors/prices'
import { getProjectBuilderStep, getProjectBuilderAttributes } from '@selectors/projectBuilder'

import BrandIdentity from './BrandIdentity'

class BrandIdentityContainer extends Component {
  handleToggle = () => {
    const { upgradePackage, openStep, changeAttributes, saveStep } = this.props

    changeAttributes({ upgradePackage: !upgradePackage })
    saveStep(openStep)
  }

  render () {
    return (
      <BrandIdentity
        {...this.props}
        onToggle={this.handleToggle}
      />
    )
  }
}

const mapStateToProps = (state, { match }) => {
  const attributes = getProjectBuilderAttributes(state)
  const stepName = match.params.step
  const openStep = getProjectBuilderStep(state, stepName)

  return {
    openStep,
    upgradePackage: attributes.upgradePackage,
    price: upgradePackagingPriceSelector(state).toFormat('$0,0.00'),
  }
}

export default withRouter(connect(mapStateToProps, {
  changeAttributes,
  saveStep
})(BrandIdentityContainer))
