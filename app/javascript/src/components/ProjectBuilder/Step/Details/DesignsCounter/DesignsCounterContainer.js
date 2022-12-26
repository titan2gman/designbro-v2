import React, { Component } from 'react'
import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom'

import { changeAttributes, saveStep } from '@actions/projectBuilder'
import { getProjectBuilderStep, getProjectBuilderAttributes } from '@selectors/projectBuilder'
import { currentProjectAdditionalDesignPriceSelector } from '@selectors/prices'

import AdditionalPriceCounter from '../AdditionalPriceCounter'

class DesignsCounterContainer extends Component {
  handleUp = () => {
    const { count, maxCount, openStep, changeAttributes, saveStep } = this.props

    if (count < maxCount) {
      changeAttributes({ maxSpotsCount: count + 1 })
      saveStep(openStep)
    }
  }

  handleDown = () => {
    const { count, minCount, openStep, changeAttributes, saveStep } = this.props

    if (count > minCount) {
      changeAttributes({ maxSpotsCount: count - 1 })
      saveStep(openStep)
    }
  }

  render () {
    return (
      <AdditionalPriceCounter
        {...this.props}
        title="How many designs would you like?"
        description="Select the number of designs you would like to choose from. Our recommendation: Go for at least 5. Remember, you only pick 1 final design."
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
  const additionalPrice = currentProjectAdditionalDesignPriceSelector(state)

  return {
    minCount: 3,
    maxCount: 10,
    openStep,
    count: attributes.maxSpotsCount,
    additionalPrice: additionalPrice.toFormat('$0,0.00'),
    isAdditionalPriceZero: additionalPrice.isZero()
  }
}

export default withRouter(connect(mapStateToProps, {
  changeAttributes,
  saveStep
})(DesignsCounterContainer))
