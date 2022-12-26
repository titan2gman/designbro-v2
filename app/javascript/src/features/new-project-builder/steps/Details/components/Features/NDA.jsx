import React from 'react'

//components
import FeatureContainer from '../Feature/FeatureContainer'
import LeftPanel from '../Feature/LeftPanel'
import Price from '../../../../components/Price'
import RightPanel from '../Feature/RightPanel'
import Description from '../Feature/Description'
import Button from '../../../../components/Button/Button'
import StandartNdaModal from './StandardNdaModal'

//assets
import NDAIcon from '../../../../../../../../assets/images/new-project-details/Icon-NDA-New.svg'

export const NDA = ({ ndaType, price, onChange }) => {
  return (
    <FeatureContainer>
      <LeftPanel icon={NDAIcon}>
        <Description title={'Make it a secret (NDA)'}>
          Keep your project a total secret by getting our designers to agree to
          a confidentiality agreement before they get to see your briefings. See
          the text <StandartNdaModal/>.
        </Description>
      </LeftPanel>
      <RightPanel>
        <Price price={price} />
        <Button type="button" add added={ndaType === 'standard'} onClick={onChange} />
      </RightPanel>
    </FeatureContainer>
  )
}
