import { brandBackgroundColors } from '@constants/colors'

export const setBrandBackgroundColors = (logo, index) => {

  return logo ? {
    background: `center / contain no-repeat url(${logo})`
  } : {
    background: brandBackgroundColors[index % brandBackgroundColors.length]
  }
}
