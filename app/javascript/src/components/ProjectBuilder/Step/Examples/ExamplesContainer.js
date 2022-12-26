import { compose } from 'redux'
import { connect } from 'react-redux'
import { loadBrandExamples } from '@actions/brandExamples'

import { withSpinner } from '@components/withSpinner'

import { isProjectBuilderInProgress } from '@selectors/projectBuilder'
import { areBrandExamplesInProgress } from '@selectors/brandExamples'

import Examples from './Examples'

const mapStateToProps = (state) => ({
  inProgress: isProjectBuilderInProgress(state)
})

export default compose(
  connect(mapStateToProps, {
    loadBrandExamples
  }),
  withSpinner,
)(Examples)
