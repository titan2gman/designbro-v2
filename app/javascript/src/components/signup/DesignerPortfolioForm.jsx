import _ from 'lodash'
import React from 'react'
import PropTypes from 'prop-types'

import Row from '../inputs/Row'

import PortfolioUploader from '@components/inputs/PortfolioUploader'

const PortfolioSection = ({
  header,
  productCategoryId,
  portfolioWorks,
  validation,
  uploadPortfolioFile,
  changePortfolioWorkAttribute
}) => (
  <section className="join-profile-info__group">
    <h2 className="join-profile-info__form-title">
      {header}
    </h2>

    <Row columnClass="col-sm-6 col-md-4 col-xl-3">
      {portfolioWorks.map((work, index) => (
        <PortfolioUploader
          key={index}
          index={index}
          work={work}
          validation={_.get(validation, [index], {})}
          productCategoryId={productCategoryId}
          onUpload={uploadPortfolioFile(productCategoryId, index)}
          changePortfolioWorkAttribute={changePortfolioWorkAttribute}
        />
      ))}
    </Row>
  </section>
)

PortfolioSection.propTypes = {
  field: PropTypes.string.isRequired,
  header: PropTypes.string.isRequired
}

const SignupDesignerPortfolioForm = ({
  experiences,
  validation,
  productCategories,
  portfolioAttributes,
  submitPortfolio,
  uploadPortfolioFile,
  changePortfolioWorkAttribute
}) => (
  <>
    {experiences.map((experience) => (
      <PortfolioSection
        key={experience.product_category_id}
        header={productCategories[experience.product_category_id].fullName}
        productCategoryId={experience.product_category_id}
        portfolioWorks={portfolioAttributes[experience.product_category_id]}
        validation={_.get(validation, [experience.product_category_id])}
        uploadPortfolioFile={uploadPortfolioFile}
        changePortfolioWorkAttribute={changePortfolioWorkAttribute}
      />
    ))}

    <button
      className="join-upload-portfolio__action main-button main-button--pink-black main-button--lg font-16 m-b-20"
      onClick={submitPortfolio}
    >
      Submit Portfolio

      <i className="m-l-15 font-8 icon-arrow-right-long" />
    </button>
  </>
)

SignupDesignerPortfolioForm.propTypes = {
  packaging: PropTypes.bool.isRequired,
  brandIdentity: PropTypes.bool.isRequired,
  onSubmitBtnClick: PropTypes.func.isRequired
}

export default SignupDesignerPortfolioForm
