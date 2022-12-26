import React from 'react'
import Dinero from 'dinero.js'

//components
import FeatureContainer from '../Feature/FeatureContainer'
import LeftPanel from '../Feature/LeftPanel'
import Price from '../../../../components/Price'
import RightPanel from '../Feature/RightPanel'
import Description from '../Feature/Description'
import Button from '../../../../components/Button/Button'

import { blindProjectPrice } from '@constants/prices'

//assets
import BlindIcon from '../../../../../../../../assets/images/new-project-details/Icon-BlindProject-New.svg'

export const BlindProject = () => {
  return (
    <FeatureContainer>
      <LeftPanel icon={BlindIcon}>
        <Description title={'Blind project'}>
          Designers can’t see each other’s work, so you receive more creativity
          and originality.
        </Description>
      </LeftPanel>
      <RightPanel>
        <Price isFree={true} price={`+ ${Dinero({ amount: blindProjectPrice * 100 }).toFormat('$0,0')}`} />
        <Button disabled={true} add={true} added={true}/>
      </RightPanel>
    </FeatureContainer>
  )
}
