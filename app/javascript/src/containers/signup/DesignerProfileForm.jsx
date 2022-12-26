import { connect } from 'react-redux'

import {
  changeProfileAttribute,
  changeProfileExperience,
  saveProfileAttributes
} from '@actions/designer'

import { getMe } from '@reducers/me'
import { getProductCategoriesWithoutOther } from '@selectors/product'

import SignupDesignerProfileForm from '@components/signup/DesignerProfileForm'

const mapStateToProps = (state) => ({
  me: getMe(state),
  attributes: state.designer.profileAttributes,
  errors: state.validations.designerProfileErrors,
  productCategories: getProductCategoriesWithoutOther(state)
})

export default connect(mapStateToProps, {
  changeProfileAttribute,
  changeProfileExperience,
  saveProfileAttributes
})(SignupDesignerProfileForm)
