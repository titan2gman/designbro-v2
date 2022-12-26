import React from 'react'
import Input from '@components/inputs/Input'

const BrandNameForm = ({ isNewBrand, brandName, onChange }) => {
  if (isNewBrand) {
    return (
      <div className="brand-name-input">
        <p>Let us know your new brand name:</p>

        <Input
          name="brandName"
          value={brandName}
          label="Brand name"
          onChange={onChange}
        />
      </div>
    )
  }

  return null
}

export default BrandNameForm
