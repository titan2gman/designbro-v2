import times from 'lodash/times'

const portfolioSlidesSizeCallback = (imagesCount) => (accumulator, i) => {
  accumulator[i] = imagesCount < i ? imagesCount : i
  return accumulator
}

const portfolioSlidesSize = (imagesCount) => times(4, (i) => i + 1).reduce(portfolioSlidesSizeCallback(imagesCount), [])

export default portfolioSlidesSize
