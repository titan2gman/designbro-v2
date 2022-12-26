import React from 'react'

//components
import FeatureContainer from '../Feature/FeatureContainer'
import LeftPanel from '../Feature/LeftPanel'
import Price from '../../../../components/Price'
import RightPanel from '../Feature/RightPanel'
import Description from '../Feature/Description'
import Button from '../../../../components/Button/Button'

//assets
import BrandIcon from '../../../../../../../../assets/images/new-project-details/Icon-BrandIdentity-New.svg'

export const BrandIdentity = ({ price, value, onChange }) => {
  return (
    <FeatureContainer>
      <LeftPanel icon={BrandIcon}>
        <Description title={'Add full brand-identity'}>
          Includes custom made: letterhead, business cards, envelope and
          compliment note design.
        </Description>
      </LeftPanel>
      <RightPanel>
        <Price price={price} />
        <Button type="button" add={true} added={value} onClick={onChange} />
      </RightPanel>
    </FeatureContainer>
  )
}
