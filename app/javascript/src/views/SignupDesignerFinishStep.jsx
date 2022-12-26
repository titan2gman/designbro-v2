import { compose } from 'redux'

import { withDesignerSignupLayout } from '../layouts'

import { requireDesignerAuthentication } from '../authentication'

import SignupDesignerFinishStep from '../components/signup/DesignerFinishStep'

export default compose(
  withDesignerSignupLayout,
  requireDesignerAuthentication
)(SignupDesignerFinishStep)
