import { connect } from 'react-redux'

import {
  uploadPortfolioFile,
  changeProfileExperience,
  changePortfolioWorkAttribute,
  submitExperienceSettings
} from '@actions/designer'

import { getMe } from '@reducers/me'
import { getProductCategoriesWithoutOther } from '@selectors/product'

import ExperienceSettings from './ExperienceSettings'

const mapStateToProps = (state) => {
  const me = getMe(state)

  return {
    me,
    works: state.designer.portfolioAttributes,
    attributes: state.designer.profileAttributes,
    initialExperiences: me.experiences,
    productCategories: getProductCategoriesWithoutOther(state),
    validation: state.validations.designerPortfolioErrors,
  }
}

export default connect(mapStateToProps, {
  uploadPortfolioFile,
  changeProfileExperience,
  changePortfolioWorkAttribute,
  submitExperienceSettings
})(ExperienceSettings)
