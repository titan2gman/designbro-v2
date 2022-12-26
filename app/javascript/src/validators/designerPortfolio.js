import _ from 'lodash'

export const validateDesignerPortfolio = (state) => {
  const validation = {}

  _.forEach(state.designer.portfolioAttributes, (productCategoryWorks, productCategoryId) => {
    validation[productCategoryId] = productCategoryWorks.map((work) => {
      const workValidation = {}

      if (!work.uploadedFileId) {
        workValidation.uploadedFileId = 'Required'
      }

      if (!work.description) {
        workValidation.description = 'Required'
      }

      return workValidation
    })
  })

  return validation
}

export const isDesignerPortfolioValid = (validation) => {
  return _.every(_.flatten(_.values(validation)), _.isEmpty)
}
