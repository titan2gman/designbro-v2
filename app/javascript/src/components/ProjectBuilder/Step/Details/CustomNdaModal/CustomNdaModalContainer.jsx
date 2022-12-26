import React, { Component } from 'react'
import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom'

import { changeAttributes, saveStep } from '@actions/projectBuilder'
import { getProjectBuilderStep, getProjectBuilderAttributes } from '@selectors/projectBuilder'

import { Textarea } from '../../../inputs'
import MaterialModal from '@containers/MaterialModal'

class CustomNdaModal extends Component {
  handleSave = () => {
    const { openStep, changeAttributes, saveStep } = this.props

    changeAttributes({
      ndaType: 'custom'
    })

    saveStep(openStep)
  }

  render () {
    return (
      <MaterialModal
        value={(
          <Textarea
            name="ndaValue"
            maxLength="15000"
            label="Text of your NDA"
          />
        )}
        trigger="here"
        linkClasses="nda-preview-link"
        title="Custom Non-Disclosure Agreement"
        onOkButton={this.handleSave}
        okButton="Save"
      />
    )
  }
}


const mapStateToProps = (state, { match }) => {
  const stepName = match.params.step
  const openStep = getProjectBuilderStep(state, stepName)

  return {
    openStep
  }
}

export default withRouter(connect(mapStateToProps, {
  changeAttributes,
  saveStep
})(CustomNdaModal))
