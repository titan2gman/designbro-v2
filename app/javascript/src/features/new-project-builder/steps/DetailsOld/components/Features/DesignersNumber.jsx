import React from 'react'

//components
import FeatureContainer from '../Feature/FeatureContainer'
import LeftPanel from '../Feature/LeftPanel'
import RightPanel from '../Feature/RightPanel'
import Description from '../Feature/Description'
import DesignersCounter from '../DesignersCounter'

export const DesignersNumber = ({
  minCount,
  maxCount,
  value,
  price,
  onChange
}) => {
  return (
    <FeatureContainer>
      <LeftPanel isRightBorder={true}>
        <Description title={'How many designers would you like?'}>
          Select the number of designs you would like to choose from. Our
          recommendation: Go for at least 5. Remember, you only pick 1 final
          design.
        </Description>
      </LeftPanel>
      <RightPanel isDesignerCounter={true}>
        <DesignersCounter
          minCount={minCount}
          maxCount={maxCount}
          value={value}
          price={price}
          onChange={onChange}
        />
      </RightPanel>
    </FeatureContainer>
  )
}
