import React, { useEffect } from 'react'
import PropTypes from 'prop-types'

import Testimonial from '@client/containers/Testimonial'

import DesignsCounter from './DesignsCounter'
import ScreensCounter from './ScreensCounter'
import TopDesigners from './TopDesigners'
import BlindProject from './BlindProject'
import Nda from './Nda'
import BusinessCardDesign from './BusinessCardDesign'
import LetterheadDesign from './LetterheadDesign'
import BrandIdentity from './BrandIdentity'
import WebsiteDesign from './WebsiteDesign'

import Summary from '../Summary'
import Discount from './Discount'
import Total from '../Total'

import PaymentMethods from './PaymentMethods'
import MoneyBackGuarantee from './MoneyBackGuarantee'

import { Spinner } from '@components/withSpinner'

const Details = ({ inProgress, productKey, project, loadProducts, loadNdaPrices, loadVatRates, loadTestimonial }) => {
  useEffect(() => {
    loadProducts()
    loadNdaPrices()
    loadVatRates()
    loadTestimonial()
  }, [])

  if (inProgress) {
    return <Spinner />
  }

  return (
    <div className="row m-b-30">
      <div className="col-md-7">
        {project.projectType === 'contest' && (
          <DesignsCounter />
        )}

        {['website'].includes(productKey) && (
          <ScreensCounter />
        )}

        <TopDesigners />

        <BlindProject />

        <Nda />

        {false && (
          <BusinessCardDesign />
        )}

        {false && (
          <LetterheadDesign />
        )}

        {['logo'].includes(productKey) && (
          <BrandIdentity />
        )}

        {false && (
          <WebsiteDesign />
        )}
      </div>

      <div className="col-md-5 p-l-40">
        <Summary />

        <Total />

        <Discount />

        <MoneyBackGuarantee />
        <PaymentMethods />
        <Testimonial />
      </div>
    </div>
  )
}

Details.propTypes = {
  productKey: PropTypes.string.isRequired,
  handleSubmit: PropTypes.func.isRequired
}

export default Details
