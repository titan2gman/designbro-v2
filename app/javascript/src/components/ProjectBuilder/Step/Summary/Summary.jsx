import React from 'react'

import TopDesignersPrice from './TopDesignersPrice'
import BlindProjectPrice from './BlindProjectPrice'

import ProductPrice from './ProductPrice'
import ExtraScreensPrice from './ExtraScreensPrice'
import ExtraDesignsPrice from './ExtraDesignsPrice'
import DiscountAmount from './DiscountAmount'
import NdaPrice from './NdaPrice'
import VatAmount from './VatAmount'
import UpgradePackagePrice from './UpgradePackagePrice'
import SavingsAmount from './SavingsAmount'

const Summary = () => {
  return (
    <div className="summary">
      <h2>Summary</h2>

      <ProductPrice />
      
      <ExtraScreensPrice />

      <ExtraDesignsPrice />

      <TopDesignersPrice />

      <BlindProjectPrice />

      <UpgradePackagePrice />

      <NdaPrice />

      <DiscountAmount />

      <VatAmount />

      <SavingsAmount />
    </div>
  )
}

export default Summary
