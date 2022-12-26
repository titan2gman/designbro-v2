import React from 'react'
import PropTypes from 'prop-types'

import { RadioButton } from '../../inputs'
import BrandSelector from '../BrandSelector'

const OptionalBrandSelector = ({ brandExists }) => (
  <div className="bfs-existing-design">
    <p className="bfs-hint__text">
      Do you have a brand name?
    </p>

    <div className="m-b-10">
      <span className="main-radio">
        <RadioButton
          label="Yes"
          value="yes"
          name="brandExists"
        />
      </span>

      <span className="main-radio m-r-20">
        <RadioButton
          label="No"
          value="no"
          name="brandExists"
        />
      </span>
    </div>

    {brandExists && (
      <BrandSelector />
    )}
  </div>
)

OptionalBrandSelector.propTypes = {
  brandExists: PropTypes.bool.isRequired
}

export default OptionalBrandSelector
