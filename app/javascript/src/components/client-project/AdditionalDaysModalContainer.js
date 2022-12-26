import React, { Component } from 'react'
import _ from 'lodash'
import { connect } from 'react-redux'
import Dinero from 'dinero.js'

import { ADDITIONAL_DAY_PRICE, MAX_ADDITIONAL_DAYS } from '@constants'
import { showAdditionalDaysPaymentModal, hideModal } from '@actions/modal'
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

  handleContinue = () => {
    const { project, showAdditionalDaysPaymentModal } = this.props
    showAdditionalDaysPaymentModal({ project })
  }

  render () {
    return (
      <UpsellModal
        {...this.props}
        onUp={this.handleUp}
        onDown={this.handleDown}
        onContinue={this.handleContinue}
      />
    )
  }
}

const mapStateToProps = (state, { project }) => {
  const { numberOfDays } = getProjectBuilderUpsellAttributes(state)

  const minCount = 1
  const maxCount = MAX_ADDITIONAL_DAYS - project.additionalDays

  const totalCost = Dinero({
    amount: numberOfDays * ADDITIONAL_DAY_PRICE * 100
  })

  return {
    id: project.id,
    count: numberOfDays,
    totalCost: totalCost.toFormat('$0,0.00'),
    minCount,
    maxCount,
    title: <>How many days<br/>would you like to add</>
  }
}

export default connect(mapStateToProps, {
  showAdditionalDaysPaymentModal,
  changeUpsellAttributes,
  onClose: hideModal
})(UpsellModalContainer)
