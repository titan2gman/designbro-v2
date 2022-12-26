import { connect } from 'react-redux'

import { upload, destroy } from '@actions/featuredImage'

import FeaturedImageUploader from './FeaturedImageUploader'
import { getFeaturedImage } from '@selectors/featuredImage'

const mapStateToProps = (state) => ({
  ...getFeaturedImage(state)
})

export default connect(mapStateToProps, {
  upload,
  destroy
})(FeaturedImageUploader)
