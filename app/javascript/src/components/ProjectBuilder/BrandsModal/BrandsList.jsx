import React from 'react'
import PropTypes from 'prop-types'
import BrandItem from './BrandItemContainer'
import NewBrand from './NewBrandContainer'

const BrandsList = ({ brands }) => (
  <main className="product-brands-list">
    <NewBrand />

    {brands.map((brand, index) => {
      return (
        <BrandItem
          key={brand.id}
          index={index}
          brand={brand}
        />
      )
    })}
  </main>
)

BrandsList.propTypes = {
  brands: PropTypes.array.isRequired
}

export default BrandsList
