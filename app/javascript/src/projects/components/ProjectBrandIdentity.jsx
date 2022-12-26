import React from 'react'
import Slider from '@projects/components/Slider'

export default ({ brandDna }) => (
  <div>
    <p className="brief-section__title" id="brand-identity">Brand DNA</p>

    <Slider
      from="Serious"
      to="Playful"
      value={brandDna.seriousOrPlayful}
    />

    <Slider
      from="Bold"
      to="Refined"
      value={brandDna.boldOrRefined}
    />

    <Slider
      from="Handcrafted"
      to="Minimalist"
      value={brandDna.handcraftedOrMinimalist}
    />

    <Slider
      from="Traditional"
      to="Modern"
      value={brandDna.traditionalOrModern}
    />

    <Slider
      from="Value"
      to="Premium"
      value={brandDna.valueOrPremium}
    />

    <Slider
      from="Detailed"
      to="Clean"
      value={brandDna.detailedOrClean}
    />

    <Slider
      from="Stand out from the crowd"
      to="Fit in, look as if it belongs in the category"
      value={brandDna.standOutOrNotFromTheCrowd}
    />

    <Slider
      from="Look as if it has been around for 100 years"
      to="Startup ready to take on the world"
      value={brandDna.outmodedActual}
    />
  </div>
)
