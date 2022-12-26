import React, { Component } from 'react'
import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom'

import { changeAttributes, saveStep } from '@actions/projectBuilder'
import { customNdaPriceSelector, standardNdaPriceSelector } from '@selectors/prices'
import { getProjectBuilderAttributes, getProjectBuilderStep } from '@selectors/projectBuilder'

import Nda from './Nda'

class NdaContainer extends Component {
  handleToggle = () => {
    const { ndaType, openStep, changeAttributes, saveStep } = this.props

    changeAttributes({
      ndaType: ndaType === 'free' ? 'standard' : 'free',
      ndaValue: ''
    })

    saveStep(openStep)
  }

  render() {
    const { ndaIsPaid, ndaType, price } = this.props

    if (ndaIsPaid) {
      return null
    }

    return (
      <Nda
        price={price}
        isAdded={['standard', 'custom'].includes(ndaType)}
        onToggle={this.handleToggle}
      />
    )
  }
}

const mapStateToProps = (state, { match }) => {
  const stepName = match.params.step
  const openStep = getProjectBuilderStep(state, stepName)

  const attributes = getProjectBuilderAttributes(state)
  const { ndaType, ndaIsPaid } = attributes

  const standardPrice = standardNdaPriceSelector(state).toFormat('$0,0.00')

  return {
    openStep,
    ndaIsPaid,
    ndaType,
    price: standardPrice
  }
}

export default withRouter(connect(mapStateToProps, {
  changeAttributes,
  saveStep
})(NdaContainer))
