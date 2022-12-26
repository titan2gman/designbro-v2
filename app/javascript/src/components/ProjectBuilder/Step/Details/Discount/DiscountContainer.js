import React, { Component } from 'react'
import { connect } from 'react-redux'

import { checkDiscount } from '@actions/discount'
import { changeAttributes } from '@actions/projectBuilder'

import { currentDiscountValueSelector, isCurrentDiscountValidSelector } from '@selectors/discount'

import Discount from './Discount'

class DiscountContainer extends Component {
  handleChange = (event) => {
    const value = event.target.value
    const { checkDiscount, changeAttributes } = this.props

    checkDiscount(value)
    changeAttributes({
      'discountCode': value
    })
  }

  render () {
    const { discountCode, isValid, inProgress } = this.props

    return (
      <Discount
        discountCode={discountCode}
        isValid={isValid}
        inProgress={inProgress}
        onChange={this.handleChange}
      />
    )
  }
}

const mapStateToProps = (state) => {
  return {
    inProgress: state.projectDiscount.inProgress,
    discountCode: currentDiscountValueSelector(state),
    isValid: isCurrentDiscountValidSelector(state)
  }
}

export default connect(mapStateToProps, {
  checkDiscount,
  changeAttributes
})(DiscountContainer)
