import { connect } from 'react-redux'
import { compose } from 'redux'
import moment from 'moment'
import _ from 'lodash'
import Dinero from 'dinero.js'
import { parse } from 'query-string'

import { ADDITIONAL_SPOTS_SURCHARGE } from '@constants'

import {
  getSpotsLoaded,
  getVisibleSpots,
  getFinalistsSpots,
  getInProgressSpots,
  getCurrentProjectWinner
} from '../../reducers/spots'

import { showAdditionalSpotsModal } from '@actions/modal'

import { withSpinner } from '@components/withSpinner'

import { getCurrentProject } from '@selectors/projects'
import { currentProjectAdditionalDesignPricesSelector } from '@selectors/prices'

import Designs from '@components/client-project/Designs'

const inProgressStates = ['design_stage']
const finalistsStates = ['design_stage', 'finalist_stage']

const mapStateToProps = (state, props) => {
  const finalistSpots = getFinalistsSpots(state)
  const winnerSpot = getCurrentProjectWinner(state)
  const project = getCurrentProject(state)
  const finalistSpotsExist = _.isEmpty(finalistSpots)
  const hoursTillDesignStageExpires = moment.duration(moment(project.designStageExpiresAt).diff(moment())).asHours()
  const additionalDesignPrices = currentProjectAdditionalDesignPricesSelector(state)
  const designIdParam = parse(props.location.search).design_id
  let addSpotPrice

  if (project.maxSpotsCount < 10) {
    const currentAdditionalDesignPrice = _.get(additionalDesignPrices.find((p) => p.quantity === project.maxSpotsCount), 'amount', 0)
    const nextAdditionalDesignPrice = _.get(additionalDesignPrices.find((p) => p.quantity === project.maxSpotsCount + 1), 'amount', 0)
    const addSpotPriceObj = Dinero({
      amount: (nextAdditionalDesignPrice - currentAdditionalDesignPrice) * (100 + ADDITIONAL_SPOTS_SURCHARGE)
    })

    addSpotPrice = addSpotPriceObj.toFormat('$0,0.00')
  }

  return {
    project,
    winnerSpot,

    finalistSpots,
    inProgressSpots: getInProgressSpots(state),
    visibleSpots: _.sortBy(getVisibleSpots(state), ['createdAt']),

    isSpotsVisible: finalistSpotsExist && _.includes(inProgressStates, project.state),
    isFinalistsTabVisible: !finalistSpotsExist && _.includes(finalistsStates, project.state),
    isInProgressTabVisible: !finalistSpotsExist && _.includes(inProgressStates, project.state),
    isAddSpotVisible: project.state === 'design_stage' && hoursTillDesignStageExpires > 48 && project.maxSpotsCount < 10,
    addSpotPrice,
    designIdParam
  }
}

export default connect(mapStateToProps, {
  showAdditionalSpotsModal
})(Designs)
