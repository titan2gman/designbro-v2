import React from 'react'
import countries from 'country-list'
import Slider from '../../projects/components/Slider'

export default ({ brandDna }) => (
  <div className="brief-section" id="target-audience">
    <p className="brief-section__title">
      Target audience
    </p>

    <div className="brief__target">
      <Slider from="Youthful" to="Mature" value={brandDna.youthfulOrMature} />
      <Slider from="Masculine" to="Feminine" value={brandDna.masculineOrPremium} />
      <Slider from="Low income" to="High income" value={brandDna.lowIncomeOrHighIncome} />
    </div>

    {brandDna.targetCountryCodes && brandDna.targetCountryCodes.length > 0 && <div>
      <p className="brief__title--sm">Countries where design will be aimed at</p>

      {brandDna.targetCountryCodes.map((code, index) => (
        <div key={index}>
          {code !== brandDna.targetCountryCodes[0] &&
            <span className="m-l-10 m-r-10">/</span>}

          {countries.getName(code)}
        </div>
      ))}
    </div>}
  </div>
)
