import { connect } from 'react-redux'
import { compose } from 'redux'

import { withSpinner } from '@components/withSpinner'
import { showModal } from '@actions/modal'

import { getMe } from '@reducers/me'
import { getMySpots } from '@reducers/spots'
import { getCurrentProject } from '@selectors/projects'
import { currentProductSelector } from '@selectors/product'
import { getCurrentBrand } from '@selectors/brands'
import { getCurrentBrandDna } from '@selectors/brandDnas'
import { getBadExamples, getGoodExamples } from '@selectors/projectBrandExamples'
import { getCompetitors } from '@selectors/competitors'
import { getExistingDesigns } from '@selectors/existingDesigns'
import { getInspirations } from '@selectors/inspirations'
import { isColorsExist } from '@selectors/projectColors'
import { getAdditionalDocuments } from '@selectors/projectAdditionalDocuments'
import { getStockImages } from  '@selectors/projectStockImages'
import { getProjectNewBrandExamples } from '@selectors/projectNewBrandExamples'

import ProjectBrief from '@components/designer-project/ProjectBrief'

const mapStateToProps = (state) => {
  const inProgress = state.projects.inProgress
  const project = getCurrentProject(state)

  if (inProgress || !project) {
    return {
      inProgress: true
    }
  }

  return {
    inProgress,
    project,
    product: currentProductSelector(state),
    me: getMe(state),
    additionalDocuments: getAdditionalDocuments(state),
    badExamples: getBadExamples(state),
    colorsExist: isColorsExist(state),
    competitors: getCompetitors(state),
    existingLogos: getExistingDesigns(state),
    goodExamples: getGoodExamples(state),
    inspirations: getInspirations(state),
    spots: getMySpots(state),
    brand: getCurrentBrand(state),
    brandDna: getCurrentBrandDna(state),
    stockImages: getStockImages(state),
    newExamples: getProjectNewBrandExamples(state)
  }
}

export default compose(
  connect(mapStateToProps, {
    showModal
  }),
  withSpinner
)(ProjectBrief)
