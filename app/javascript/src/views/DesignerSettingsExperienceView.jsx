import React, { Component } from 'react'
import { compose } from 'redux'

import { withDesignerSettingsLayout } from '../layouts'

import { requireDesignerAuthentication } from '../authentication'

import DesignerSettingsExperience from '@settings/components/DesignerSettingsExperience'

export default compose(
  withDesignerSettingsLayout,
  requireDesignerAuthentication
)(DesignerSettingsExperience)
