import React, { Component } from 'react'
import _ from 'lodash'
import Dinero from 'dinero.js'
import { connect } from 'react-redux'

import { ADDITIONAL_DAY_PRICE } from '@constants'
import { hideModal } from '@actions/modal'
import { buyDaysUpsellWithPaypalPayment, buyDaysUpsellWithStripePayment } from '@actions/projectBuilder'

import { getVatRates, isNotIreland } from '@selectors/vat'
import { currentDiscountSelector } from '@selectors/discount'
import { getMe } from '@selectors/me'
import { getCurrentProject } from '@selectors/projects'
import { getProjectBuilderAttributes, getProjectBuilderUpsellAttributes } from '@selectors/projectBuilder'
import { discountInDollars, currentProjectAdditionalDesignPricesSelector } from '@selectors/prices'

import PaymentModal from '../ProjectBuilder/New/PaymentModal/PaymentModal'

const getVatRateByCountry = (vatRates, countryCode) => {
  return _.find(vatRates, (v) => v.countryCode === countryCode)
}

const getVat = (price, vatRate, vatNumber) => {
  const shouldHaveVat = vatRate && !(isNotIreland(vatRate.countryCode) && vatNumber)
  const vatMultiplier = shouldHaveVat ? vatRate.percent / 100 : 0

  return price.multiply(vatMultiplier)
}

const displayDiscountAmount = (discount) => {
  if (!discount) {
    return null
  }

  switch (discount.discountType) {
  case 'percent':
    return `${discount.value}%`
  case 'dollar':
    return `$${discount.value}`
  default:
    return null
  }
}

const PaymentModalContainer = ({ buyDaysUpsellWithPaypalPayment, buyDaysUpsellWithStripePayment, project, ...props }) => (
  <PaymentModal
    {...props}
    onPaypalSuccess={buyDaysUpsellWithPaypalPayment(project)}
    onStripeSuccess={buyDaysUpsellWithStripePayment(project)}
  />
)

const mapStateToProps = (state, { project }) => {
  const me = getMe(state)
  const { preferredPaymentMethod, countryCode, vat: vatNumber, creditCardNumber, creditCardProvider } = me

  const attributes = getProjectBuilderAttributes(state)

  const { numberOfDays } = getProjectBuilderUpsellAttributes(state)

  const price = Dinero({
    amount: numberOfDays * ADDITIONAL_DAY_PRICE * 100
  })

  const discount = currentDiscountSelector(state)

  const discountAmount = displayDiscountAmount(discount)
  const isDiscountVisible = discount && discount.available

  const vatRates = getVatRates(state)

  const vatRate = getVatRateByCountry(vatRates, countryCode)
  const isVatVisible = countryCode && vatRate

  const priceWithDiscount = price.subtract(discountInDollars(price, discount))

  const vat = getVat(priceWithDiscount, vatRate, vatNumber)

  const total = priceWithDiscount.add(vat)

  return {
    project,
    paymentType: attributes.paymentType,
    basePriceName: 'Additional day(s)',
    basePriceValue: price.toFormat('$0,0.00'),
    isVatVisible,
    vatValue: vat.toFormat('$0,0.00'),
    totalValue: total.toFormat('$0,0.00'),
    paypalAmount: total.toRoundedUnit(2),
    hasCard: creditCardNumber && creditCardProvider,
    creditCardNumber,
    creditCardProvider,
    discountAmount: `- ${discountAmount}`,
    isDiscountVisible
  }
}

export default connect(mapStateToProps, {
  buyDaysUpsellWithPaypalPayment,
  buyDaysUpsellWithStripePayment,
  onClose: hideModal
})(PaymentModalContainer)
