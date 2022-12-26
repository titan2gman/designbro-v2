import { connect } from 'react-redux'
import { showFinishStepLogoModal } from '@actions/modal'
import { currentProductShortNameSelector } from '@selectors/product'
import { getProjectBuilderAttributes } from '@selectors/projectBuilder'

import ExistingLogos from './ExistingLogos'

const mapStateToProps = (state) => {
  const attributes = getProjectBuilderAttributes(state)

  return {
    productName: currentProductShortNameSelector(state),
    hasExistingDesigns: attributes.hasExistingDesigns,
    existingDesignsExist: attributes.existingDesignsExist,
    existingDesignUploaders: attributes.existingDesigns
  }
}

export default connect(mapStateToProps, {
  showFinishStepLogoModal
})(ExistingLogos)
