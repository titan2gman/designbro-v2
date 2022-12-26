import { connect } from 'react-redux'

import { getMe } from '@reducers/me'
import { getCurrentProject } from '@selectors/projects'
import { getCurrentBrand } from '@selectors/brands'
import { getDesignById, getMyDesigns, getDesignLoaded } from '@reducers/designs'
import { getMySpot } from '@reducers/spots'

import { showModal } from '@actions/modal'
import { uploadDesign } from '@actions/designs'

import Layout from '@components/designer-project/Layout'

const mapStateToProps = (state) => {
  return {
    project: getCurrentProject(state),
    brand: getCurrentBrand(state),
    designs: getMyDesigns(state),
    mySpot: getMySpot(state),
    me: getMe(state)
  }
}

export default connect(mapStateToProps, {
  showModal,
  uploadDesign,
})(Layout)
