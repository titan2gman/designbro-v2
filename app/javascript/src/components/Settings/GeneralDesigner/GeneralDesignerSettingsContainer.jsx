import { connect } from 'react-redux'

import {
  changeProfileAttribute,
  saveProfileSettingsAttributes
} from '@actions/designer'

import { getMe } from '@reducers/me'

import { open } from '@actions/simpleModal'

import GeneralDesignerSettings from './GeneralDesignerSettings'

const mapStateToProps = (state) => ({
  me: getMe(state),
  attributes: state.designer.profileAttributes,
  errors: state.validations.designerProfileErrors,
})

export default connect(mapStateToProps, {
  changeProfileAttribute,
  saveProfileSettingsAttributes,
  open
})(GeneralDesignerSettings)
