import { connect } from 'react-redux'

import {
  getProjectBuilderValidationErrors
} from '@selectors/projectBuilder'

import CompetitorLogoUploader from './CompetitorLogoUploader'

const mapStateToProps = (state, props) => {
  const errors = getProjectBuilderValidationErrors(state).competitors

  return {
    errors: errors && errors[props.index] || {}
  }
}


export default connect(mapStateToProps)(CompetitorLogoUploader)
