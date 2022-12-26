import React, { Component } from 'react'
import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom'

import { changeAttributes, saveStep } from '@actions/projectBuilder'
import { getProjectBuilderStep, getProjectBuilderAttributes } from '@selectors/projectBuilder'
import { currentProjectAdditionalScreenPriceSelector } from '@selectors/prices'

import AdditionalPriceCounter from '../AdditionalPriceCounter'

class ScreensCounterContainer extends Component {
  handleUp = () => {
    const { count, maxCount, openStep, changeAttributes, saveStep } = this.props

    if (count < maxCount) {
      changeAttributes({ maxScreensCount: count + 1 })
      saveStep(openStep)
    }
  }

  handleDown = () => {
    const { count, minCount, openStep, changeAttributes, saveStep } = this.props

    if (count > minCount) {
      changeAttributes({ maxScreensCount: count - 1 })
      saveStep(openStep)
    }
  }

  render () {
    return (
      <AdditionalPriceCounter
        {...this.props}
        title="How many screens would you like?"
        description="Select the number of screens you would like to have designed
        (eg. homepage, about us, contact, loading screen, etc.)"
        onUp={this.handleUp}
        onDown={this.handleDown}
      />
    )
  }
}

const mapStateToProps = (state, { match }) => {
  const stepName = match.params.step
  const openStep = getProjectBuilderStep(state, stepName)

  const attributes = getProjectBuilderAttributes(state)
  const additionalPrice = currentProjectAdditionalScreenPriceSelector(state)

  return {
    minCount: 1,
    maxCount: 10,
    openStep,
    count: attributes.maxScreensCount,
    additionalPrice: additionalPrice.toFormat('$0,0.00'),
    isAdditionalPriceZero: additionalPrice.isZero()
  }
}

export default withRouter(connect(mapStateToProps, {
  changeAttributes,
  saveStep
})(ScreensCounterContainer))
