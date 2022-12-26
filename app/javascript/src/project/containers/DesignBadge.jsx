import React from 'react'
import { withRouter } from 'react-router-dom'

import { connect } from 'react-redux'

import { getDesign } from '@reducers/designs'
import { getSpotById } from '@reducers/spots'
import { getProjectById } from '@reducers/projects'

import DesignBadge from '@project/components/DesignBadge'

const Container = ({ text }) => (
  !!text && <DesignBadge text={text} />
)

const getBadgeText = (spot) => {
  if (!spot) return null

  if (spot.banned) {
    return 'Blocked'
  }

  if (spot.state === 'winner') {
    return 'Winner'
  }

  if (spot.state === 'finalist') {
    return 'Finalist'
  }

  if (spot.state === 'eliminated') {
    return 'Eliminated'
  }
}

const mapStateToProps = (state, props) => {
  const design = getDesign(state)
  const project = getProjectById(state, props.project.id)

  if (project.projectType === 'contest' && design) {
    const text = getBadgeText(
      getSpotById(state, design.spot)
    )

    return { text }
  }

  return {}
}

export default withRouter(connect(mapStateToProps)(Container))
