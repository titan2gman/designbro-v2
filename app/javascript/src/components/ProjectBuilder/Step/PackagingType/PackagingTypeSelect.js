import React from 'react'
import PropTypes from 'prop-types'

import { Control } from 'react-redux-form'

import PackagingTypeItem from './PackagingTypeItemContainer'

const packagingTypes = [
  { type: 'can', label: 'Can' },
  { type: 'bottle', label: 'Bottle' },
  { type: 'card_box', label: 'Card Box' },
  { type: 'pouch', label: 'Pouch' },
  { type: 'plastic_pack', label: 'Plastic Pack' },
  { type: 'label', label: 'Label' },
  { type: 'other', label: 'Other' }
]

const PackagingTypeSelect = ({ onPackagingTypeChange }) => (
  <div>
    <div className="psb-content__title">
      Please select which of the following best describes
      the type of pack that you would to use:
    </div>

    <div className="psb-content__boxes">
      <div className="row">
        {packagingTypes.map(({ type, label }, index) =>
          (<Control
            key={index}
            label={label}
            packagingType={type}
            component={PackagingTypeItem}
            changeAction={onPackagingTypeChange}
            model="forms.newProjectPackagingType.packagingType"
          />)
        )}
      </div>
    </div>
  </div>
)

PackagingTypeSelect.propTypes = {
  onPackagingTypeChange: PropTypes.func
}

export default PackagingTypeSelect
