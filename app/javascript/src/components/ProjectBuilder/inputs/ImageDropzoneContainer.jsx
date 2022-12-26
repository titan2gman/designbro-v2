import _ from 'lodash'
import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom'

import {
  upload,
  destroy
} from '@actions/brandRelatedEntities'

import {
  getProjectBuilderStep,
  getProjectBuilderAttributes
} from '@selectors/projectBuilder'

import ImageDropzone from '@components/inputs/ImageDropzone'

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
  const [entityName, index] = ownProps.name.split('.')
  const uploadedFileId = _.get(stateProps.attributes, [entityName, index, 'uploadedFileId'])
  const previewUrl = _.get(stateProps.attributes, [entityName, index, 'previewUrl'])

  return {
    ...stateProps,
    ...dispatchProps,
    ...ownProps,
    uploadedFileId,
    previewUrl,
    onDelete: dispatchProps.destroy(entityName, index, uploadedFileId),
    onUpload: dispatchProps.upload(entityName, index, uploadedFileId)
  }
}

export default withRouter(
  connect(
    mapStateToProps, {
      upload,
      destroy
    }, mergeProps
  )(ImageDropzone)
)
