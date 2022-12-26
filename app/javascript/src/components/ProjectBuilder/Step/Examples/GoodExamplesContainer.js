import { connect } from 'react-redux'

import { getGoodExamples } from '@reducers/newProject'

import GoodExamples from './GoodExamples'

import { REQUIRED_GOOD_EXAMPLES_COUNT } from '@constants'

const mapStateToProps = (state) => {
  const images = getGoodExamples(state)

  return {
    images,
    isEnough: images.length >= REQUIRED_GOOD_EXAMPLES_COUNT
  }
}

export default connect(mapStateToProps)(GoodExamples)
