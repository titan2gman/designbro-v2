import React from 'react'
import PropTypes from 'prop-types'
import { withRouter } from 'react-router-dom'

import PackagingTypeSelect from './PackagingTypeSelect'

import CanPackagingTypeOptions from './packaging-type-options/CanPackagingTypeOptions'
import PouchPackagingTypeOptions from './packaging-type-options/PouchPackagingTypeOptions'
import BottlePackagingTypeOptions from './packaging-type-options/BottlePackagingTypeOptions'
import CardBoxPackagingTypeOptions from './packaging-type-options/CardBoxPackagingTypeOptions'
import OtherPackPackagingTypeOptions from './packaging-type-options/OtherPackagingTypeOptions'
import LabelPackPackagingTypeOptions from './packaging-type-options/LabelPackagingTypeOptions'
import PlasticPackPackagingTypeOptions from './packaging-type-options/PlasticPackPackagingTypeOptions'

const getPackagingTypeOptionsComponent = (packagingType, onFormChange) => {
  switch (packagingType) {
  case 'can':
    return <CanPackagingTypeOptions onFormChange={onFormChange} />
  case 'bottle':
    return <BottlePackagingTypeOptions onFormChange={onFormChange} />
  case 'card_box':
    return <CardBoxPackagingTypeOptions onFormChange={onFormChange} />
  case 'pouch':
    return <PouchPackagingTypeOptions onFormChange={onFormChange} />
  case 'plastic_pack':
    return <PlasticPackPackagingTypeOptions onFormChange={onFormChange} />
  case 'label':
    return <LabelPackPackagingTypeOptions onFormChange={onFormChange} />
  case 'other':
    return <OtherPackPackagingTypeOptions onFormChange={onFormChange} />
  default:
    return null
  }
}

const PackagingTypeStep = ({ onFormChange, onPackagingTypeChange, selectedPackagingType }) => (
  <main>
    <div className="row">
      <div className="col-md-8 offset-md-2">
        <div className="m-b-40">
          <PackagingTypeSelect onPackagingTypeChange={onPackagingTypeChange} />

          {selectedPackagingType && getPackagingTypeOptionsComponent(selectedPackagingType, onFormChange)}
        </div>
      </div>
    </div>
  </main>
)

PackagingTypeStep.propTypes = {
  onFormChange: PropTypes.func,
  onPackagingTypeChange: PropTypes.func,
  selectedPackagingType: PropTypes.string,
  onBackButtonClick: PropTypes.func.isRequired,
  onContinueButtonClick: PropTypes.func.isRequired
}

export default withRouter(PackagingTypeStep)
