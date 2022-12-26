import _ from 'lodash'
import Dinero from 'dinero.js'
import { connect } from 'react-redux'

import {
  createProjectWithPaypalPayment,
  createProjectWithStripePayment
} from '@actions/projectBuilder'

import { hideModal } from '@actions/modal'

import { projectBuilderProductSelector } from '@selectors/product'
import { getProjectBuilderAttributes } from '@selectors/projectBuilder'
import { getVatRates, isNotIreland } from '@selectors/vat'
import { currentDiscountSelector } from '@selectors/discount'
import { discountInDollars } from '@selectors/prices'
import { humanizeProjectTypeName } from '@utils/humanizer'
import { getMe } from '@selectors/me'

import PaymentModal from './PaymentModal'

const getProjectBasePrice = (product, projectType) => {
  return Dinero({
    amount: projectType === 'one_to_one' ? product.oneToOnePriceCents : product.priceCents
  })
}

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

const mapStateToProps = (state) => {
  const me = getMe(state)
  const { countryCode, vat: vatNumber, creditCardNumber, creditCardProvider } = me

  const discount = currentDiscountSelector(state)

  const discountAmount = displayDiscountAmount(discount)
  const isDiscountVisible = discount && discount.available


  const product = projectBuilderProductSelector(state)
  const vatRates = getVatRates(state)
  const attributes = getProjectBuilderAttributes(state)

  const vatRate = getVatRateByCountry(vatRates, countryCode)
  const isVatVisible = countryCode && vatRate

  const price = getProjectBasePrice(product, attributes.projectType)
  const priceWithDiscount = price.subtract(discountInDollars(price, discount))

  const vat = getVat(priceWithDiscount, vatRate, vatNumber)

  const total = priceWithDiscount.add(vat)

  return {
    paymentType: attributes.paymentType,
    basePriceName: humanizeProjectTypeName(product.key),
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
  onPaypalSuccess: createProjectWithPaypalPayment,
  onStripeSuccess: createProjectWithStripePayment,
  onClose: hideModal
})(PaymentModal)
