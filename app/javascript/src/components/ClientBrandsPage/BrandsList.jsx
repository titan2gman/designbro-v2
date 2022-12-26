import _ from 'lodash'
import React from 'react'
import PropTypes from 'prop-types'
import BrandItem from './BrandItem'
import NewBrand from './NewBrand'
import BrandsPager from './BrandsPagerContainer'

const BrandsList = ({ brands, loadBrands }) => (
  <>
    <div className="row">
      {_.map(brands, (brand, index) => {
        return (
          <BrandItem
            index={index}
            key={brand.id}
            brand={brand}
          />
        )
      })}

      <NewBrand />
    </div>

    <div className="text-center">
      <BrandsPager
        loadBrands={loadBrands}
      />
    </div>
  </>
)

BrandsList.propTypes = {
  brands: PropTypes.object.isRequired
}

export default BrandsList
