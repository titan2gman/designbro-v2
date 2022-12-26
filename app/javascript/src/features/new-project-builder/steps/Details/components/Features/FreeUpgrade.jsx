import React from 'react'

//components
import FeatureContainer from '../Feature/FeatureContainer'
import LeftPanel from '../Feature/LeftPanel'
import Price from '../../../../components/Price'
import RightPanel from '../Feature/RightPanel'
import Button from '../../../../components/Button/Button'
import Description from '../Feature/Description'

//assets
import UpgradeIcon from '../../../../../../../../assets/images/new-project-details/Icon-FreeUpgrade.svg'

export const FreeUpgrade = () => {
  return (
    <FeatureContainer>
      <LeftPanel icon={UpgradeIcon}>
        <Description title={'Extra design spot for free'}>
          You’ve earned a free upgrade because you created an all-star brief.
        </Description>
      </LeftPanel>
      <RightPanel>
        <Price isFreeUpgrade={true} />
        <Button disabled={true} add={true} added={true}/>
      </RightPanel>
    </FeatureContainer>
  )
}
