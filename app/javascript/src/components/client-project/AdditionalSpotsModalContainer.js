import React, { Component } from 'react'
import _ from 'lodash'
import { connect } from 'react-redux'
import Dinero from 'dinero.js'

import { ADDITIONAL_SPOTS_SURCHARGE } from '@constants'
import { showAdditionalSpotsPaymentModal, hideModal } from '@actions/modal'
import { changeUpsellAttributes } from '@actions/projectBuilder'
import { getProjectBuilderUpsellAttributes } from '@selectors/projectBuilder'
import { getCurrentProject } from '@selectors/projects'
import { currentProjectAdditionalDesignPricesSelector } from '@selectors/prices'

import UpsellModal from './UpsellModal'

class UpsellModalContainer extends Component {
  handleUp = () => {
    const { count, maxCount, changeUpsellAttributes } = this.props

    if (count < maxCount) {
      changeUpsellAttributes({ numberOfDays: count + 1 })
    }
  }

  handleDown = () => {
    const { count, minCount, changeUpsellAttributes } = this.props

    if (count > minCount) {
      changeUpsellAttributes({ numberOfDays: count - 1 })
    }
  }

  render () {
    return (
      <UpsellModal
        {...this.props}
        onUp={this.handleUp}
        onDown={this.handleDown}
        onContinue={this.props.showAdditionalSpotsPaymentModal}
      />
    )
  }
}


const mapStateToProps = (state) => {
  const project = getCurrentProject(state)
  const { numberOfSpots } = getProjectBuilderUpsellAttributes(state)
  const additionalDesignPrices = currentProjectAdditionalDesignPricesSelector(state)

  const maxAdditionalDesign = _.maxBy(additionalDesignPrices, 'quantity')

  const minCount = 1
  const maxCount = maxAdditionalDesign.quantity - project.maxSpotsCount

  const currentAdditionalDesignPrice = _.get(additionalDesignPrices.find((p) => p.quantity === project.maxSpotsCount), 'amount', 0)
  const newAdditionalDesignPrice = _.get(additionalDesignPrices.find((p) => p.quantity === project.maxSpotsCount + numberOfSpots), 'amount', 0)

  const totalCost = Dinero({
    amount: (newAdditionalDesignPrice - currentAdditionalDesignPrice) * (100 + ADDITIONAL_SPOTS_SURCHARGE)
  })

  return {
    count: numberOfSpots,
    totalCost: totalCost.toFormat('$0,0.00'),
    minCount,
    maxCount,
    title: <>How many spots<br/>would you like to add</>
  }
}

export default connect(mapStateToProps, {
  showAdditionalSpotsPaymentModal,
  changeUpsellAttributes,
  onClose: hideModal
})(UpsellModalContainer)
