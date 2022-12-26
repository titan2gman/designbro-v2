import _ from 'lodash'
import { connect } from 'react-redux'

import { getMe } from '@reducers/me'
import {
  uploadPortfolioFile,
  changePortfolioWorkAttribute,
  submitPortfolio
} from '@actions/designer'
import { getProductCategoriesWithoutOther } from '@selectors/product'

import SignupDesignerPortfolioForm from '@components/signup/DesignerPortfolioForm'

const mapStateToProps = (state) => {
  const me = getMe(state)

  return {
    experiences: _.filter(me.experiences, (e) => e.experience !== 'no_experience'),
    productCategories: state.entities.productCategories,
    portfolioAttributes: state.designer.portfolioAttributes,
    validation: state.validations.designerPortfolioErrors,
  }
}

export default connect(mapStateToProps, {
  uploadPortfolioFile,
  changePortfolioWorkAttribute,
  submitPortfolio
})(SignupDesignerPortfolioForm)
