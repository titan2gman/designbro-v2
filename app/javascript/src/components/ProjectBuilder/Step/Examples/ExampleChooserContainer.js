import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom'
import first from 'lodash/first'
import without from 'lodash/without'

import {
  markExampleAsBad,
  markExampleAsGood,
  markExampleAsSkip,

  incrementSkipAndCancelledExamplesIndex
} from '@actions/newProject'

import { getBrandExamples } from '@selectors/brandExamples'
import { getProjectBuilderStep } from '@selectors/projectBuilder'

import {
  getBadExamples,
  getGoodExamples,
  getSkipAndCancelledExamples,
  getSkipAndCancelledExamplesIndex
} from '@reducers/newProject'

import ExampleChooser from './ExampleChooser'

const mapStateToProps = (state, { match }) => {
  const stepName = match.params.step
  const openStep = getProjectBuilderStep(state, stepName)

  const brandExamples = getBrandExamples(state)

  const skipAndCancelledExamples = getSkipAndCancelledExamples(state)
  const skipAndCancelledExamplesIndex = getSkipAndCancelledExamplesIndex(state)

  const goodExamples = getGoodExamples(state)
  const badExamples = getBadExamples(state)

  const notShownExamples = without(brandExamples,
    ...skipAndCancelledExamples,
    ...goodExamples,
    ...badExamples
  )

  let isSkipOrCancelledExample = false
  let image = first(notShownExamples)

  if (!image) {
    const index = skipAndCancelledExamplesIndex % skipAndCancelledExamples.length
    image = skipAndCancelledExamples[index]
    isSkipOrCancelledExample = true
  }

  const canMarkExampleAsGood = goodExamples.length !== 6
  const canMarkExampleAsBad = badExamples.length !== 6

  return {
    image,
    openStep,
    inProgress: !image,
    canMarkExampleAsBad,
    canMarkExampleAsGood,
    isSkipOrCancelledExample
  }
}

const mergeProps = (stateProps, dispatchProps) => {
  const { isSkipOrCancelledExample } = stateProps

  return {
    ...stateProps,
    ...dispatchProps,

    markExampleAsSkip: (id, openStep) => (
      !isSkipOrCancelledExample ? dispatchProps.markExampleAsSkip(id, openStep)
        : dispatchProps.incrementSkipAndCancelledExamplesIndex()
    )
  }
}

export default withRouter(connect(mapStateToProps, {
  markExampleAsBad,
  markExampleAsGood,
  markExampleAsSkip,
  incrementSkipAndCancelledExamplesIndex
}, mergeProps)(ExampleChooser))
