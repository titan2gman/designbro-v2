import { connect } from 'react-redux'

import { upload, destroy } from '@actions/featuredImage'

import FeaturedImageForm from './FeaturedImageForm'
import { getFeaturedImage } from '@selectors/featuredImage'

const mapStateToProps = (state) => ({
  canContinue: !!getFeaturedImage(state).uploadedFileId
})

export default connect(mapStateToProps, {
  upload,
  destroy
})(FeaturedImageForm)
