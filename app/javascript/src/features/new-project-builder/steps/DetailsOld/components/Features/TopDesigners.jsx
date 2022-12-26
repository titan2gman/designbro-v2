import React from 'react'
import Dinero from 'dinero.js'

//components
import LeftPanel from '../Feature/LeftPanel'
import Price from '../../../../components/Price'
import RightPanel from '../Feature/RightPanel'
import Description from '../Feature/Description'
import FeatureContainer from '../Feature/FeatureContainer'
import Button from '../../../../components/Button/Button'

//assets
import DesignersIcon from '../../../../../../../../assets/images/new-project-details/Icon-TopDesigners-New.svg'

import { topDesignersPrice } from '@constants/prices'

export const TopDesigners = () => {
  return (
    <FeatureContainer>
      <LeftPanel icon={DesignersIcon}>
        <Description title={'Top designers'}>
          Only our hand-selected, professional designers will work on your
          project.
        </Description>
      </LeftPanel>
      <RightPanel>
        <Price isFree price={`+ ${Dinero({ amount: topDesignersPrice * 100 }).toFormat('$0,0')}`} />
        <Button add added disabled />
      </RightPanel>
    </FeatureContainer>
  )
}
