import React from 'react'
import HiddenInTestEnvironment from '@components/HiddenInTestEnvironment'

const ExplainerVideoSection = () => (
  <div className="bg-black">
    <div className="explainer-video-section container">
      <div className="row align-center">
        <div className="col-md-5">
          <p className="explainer-video-section__title">Find Out How It Works.</p>
          <p className="l-h-1-7">DesignBro - Agency quality design for a freelance price</p>
        </div>
        <HiddenInTestEnvironment>
          <div className="col-md-7">
            <iframe className="mb-15" width="560" height="315" src="https://www.youtube.com/embed/-fwDKQXkQHU" frameBorder="0" allowFullScreen />
          </div>
        </HiddenInTestEnvironment>
      </div>
    </div>
  </div>
)

export default ExplainerVideoSection
