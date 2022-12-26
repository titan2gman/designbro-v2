import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom'
import {
  setProjectColorByIndex,
  removeProjectColorByIndex,
  saveStep
} from '@actions/projectBuilder'

import {
  getProjectBuilderStep
} from '@selectors/projectBuilder'

import ColorPicker from './ColorPicker'

const mapStateToProps = (state, { match }) => {
  const stepName = match.params.step
  const openStep = getProjectBuilderStep(state, stepName)

  return {
    openStep
  }
}

const mergeProps = (stateProps, dispatchProps, ownProps) => {
  return {
    ...stateProps,
    ...dispatchProps,
    ...ownProps,
    pickColor: (color) => {
      dispatchProps.setProjectColorByIndex(ownProps.index, color)
      dispatchProps.saveStep(stateProps.openStep)
    },
    removeColor: () => {
      dispatchProps.removeProjectColorByIndex(ownProps.index)
      dispatchProps.saveStep(stateProps.openStep)
    }
  }
}

export default withRouter(
  connect(
    mapStateToProps, {
      setProjectColorByIndex,
      removeProjectColorByIndex,
      saveStep
    }, mergeProps
  )(ColorPicker)
)
