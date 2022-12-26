import React, { useEffect } from 'react'
import PropTypes from 'prop-types'
import { Input } from '../../inputs'
import BrandsModal from '../BrandsModal'
import BrandSwitcher from '../../BrandSwitcher'

const BrandSelector = ({ brand, hint, loadAllBrands }) => {
  useEffect(() => {
    loadAllBrands()
  }, [])

  return (
    <div className="row">
      {brand.hasPaidProject ? (
        <div className="col-md-8">
          <strong>{brand.name}</strong>

          <BrandSwitcher />
        </div>
      ) : (
        <>
          <div className="col-md-8">
            <Input
              name="brandName"
              label="Brand Name"
              hint={hint}
            />
          </div>

          <div className="col-md-4">
            <BrandSwitcher />
          </div>
        </>
      )}
    </div>
  )
}

export default BrandSelector
