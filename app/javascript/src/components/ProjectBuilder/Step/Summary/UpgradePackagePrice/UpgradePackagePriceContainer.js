import { connect } from 'react-redux'

import { currentProductSelector } from '@selectors/product'
import { upgradePackagingPriceSelector } from '@selectors/prices'
import { getProjectBuilderAttributes } from '@selectors/projectBuilder'

import SummaryItem from '../SummaryItem'

const mapStateToProps = (state) => {
  const product = currentProductSelector(state)
  const attributes = getProjectBuilderAttributes(state)

  const isVisible = attributes.upgradePackage && product.key === 'logo'
  const upgradePackagePrice = upgradePackagingPriceSelector(state).toFormat('$0,0.00')

  return {
    name: 'Upgrade Pack',
    amount: upgradePackagePrice,
    isVisible
  }
}

export default connect(mapStateToProps)(SummaryItem)
