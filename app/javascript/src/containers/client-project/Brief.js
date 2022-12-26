import { connect } from 'react-redux'
import { compose } from 'redux'
import { withSpinner } from '@components/withSpinner'

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

import ProjectBrief from '@components/shared/ProjectBrief'

const mapStateToProps = (state) => {
  return {
    inProgress: state.projects.inProgress,
    product: currentProductSelector(state),
    project: getCurrentProject(state),
    brand: getCurrentBrand(state),
    brandDna: getCurrentBrandDna(state),
    goodExamples: getGoodExamples(state),
    badExamples: getBadExamples(state),
    additionalDocuments: getAdditionalDocuments(state),
    competitors: getCompetitors(state),
    existingLogos: getExistingDesigns(state),
    inspirations: getInspirations(state),
    colorsExist: isColorsExist(state),
    stockImages: getStockImages(state),
    newExamples: getProjectNewBrandExamples(state)
  }
}

export default connect(mapStateToProps)(ProjectBrief)
