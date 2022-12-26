import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom'
import {
  changeAttributes,
  saveStep
} from '@actions/projectBuilder'

import {
  getProjectBuilderStep,
  getProjectBuilderAttributes
} from '@selectors/projectBuilder'

import Slider from './Slider'

const mapStateToProps = (state, { match }) => {
  const stepName = match.params.step
  const openStep = getProjectBuilderStep(state, stepName)
  const attributes = getProjectBuilderAttributes(state)

  return {
    openStep,
    attributes
  }
}

const mergeProps = (stateProps, dispatchProps, ownProps) => {
  return {
    ...stateProps,
    ...dispatchProps,
    ...ownProps,
    value: stateProps.attributes[ownProps.name],
    onChange: (value) => dispatchProps.changeAttributes({ [ownProps.name]: value }),
    onAfterChange: () => dispatchProps.saveStep(stateProps.openStep)
  }
}

export default withRouter(
  connect(
    mapStateToProps, {
      changeAttributes,
      saveStep
    }, mergeProps
  )(Slider)
)
