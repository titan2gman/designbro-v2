import { connect } from 'react-redux'

import {
  getDesign,
  getViewMode,
  getDesignUploaded
} from '@reducers/designs'
import { getSpotById } from '@reducers/spots'
import { getProjectById } from '@reducers/projects'

import DesignCurrentWork from '@project/components/DesignCurrentWork'

const getIsBadgePresent = (spot) => {
  if (!spot) return false

  if (spot.banned || spot.state === 'winner' || spot.state === 'finalist' || spot.state === 'eliminated') {
    return true
  } else {
    return false
  }
}

const mapStateToProps = (state, props) => {
  const loading = !getDesignUploaded(state)
  const { image: imageUrl = '' } = getDesign(state) || {}
  const isFullscreen = getViewMode(state) === 'fullscreen'
  let isBadgePresent = false

  if (props.project) {
    const design = getDesign(state)
    const project = getProjectById(state, props.project.id)
    if (project.projectType === 'contest' && design) {
      isBadgePresent = getIsBadgePresent(
        getSpotById(state, design.spot)
      )
    }
  }

  return { imageUrl, isFullscreen, loading, isBadgePresent }
}

export default connect(mapStateToProps)(DesignCurrentWork)
