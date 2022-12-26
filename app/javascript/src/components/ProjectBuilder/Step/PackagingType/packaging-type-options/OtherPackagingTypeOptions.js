import React from 'react'

import { staticHost } from '@utils/hosts'

const OtherPackagingTypeOptions = () => (
  <div className="main-modal bg-green-500 in-white">
    <div className="main-modal__inset">
      <p className="psb-popup-tech-draw__info-text m-b-30 text-center">
        Please contact us for a custom solution, we
        would love to hear what you have in mind.
      </p>

      <div className="main-modal__actions flex-end">
        <a href={`${staticHost}/contact-us`} className="main-button-link main-button-link--lg in-white" type="button">
          Contact DesignBro

          <i className="m-l-20 font-8 icon-arrow-right-long" />
        </a>
      </div>
    </div>
  </div>
)

export default OtherPackagingTypeOptions
