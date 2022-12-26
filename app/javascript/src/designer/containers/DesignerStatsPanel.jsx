import React, { Component } from 'react'
import { connect } from 'react-redux'

import pick from 'lodash/pick'
import first from 'lodash/first'

import { loadDesignerStats, DesignerStatsUpdated } from '@actions/designerStats'

import cable from '@utils/cable'

import {
  getDesignerStats,
  getDesignerStatsLoaded,
  getAvailableForPayout
} from '@reducers/designerStats'

import DesignerStatsPanel from '@designer/components/DesignerStatsPanel'

const getResultStats = (designerStats) => pick(designerStats, [
  'expiredSpotsPercentage',
  'inProgressCount',
  'finalistsCount',
  'winnersCount'
])

class DesignerStatsPanelContainer extends Component {
  componentDidMount () {
    this.props.loadDesignerStats().then((action) => {
      if (action.payload.results && action.payload.results.designerStats) {
        const channelIdentifier = {
          channel: 'DesignerStatsChannel',
          designer: first(action.payload.results.designerStats)
        }

        const { subscriptions } = cable

        this.ws = subscriptions.create(channelIdentifier, {
          received: this.props.onDesignerStatsReceived
        })
      }
    })
  }

  componentWillUnmount () {
    if (this.ws) {
      this.ws.unsubscribe()
    }
  }

  render () {
    return this.props.loaded ? <DesignerStatsPanel {...this.props} /> : null
  }
}

const mapStateToProps = (state) => {
  const loaded = getDesignerStatsLoaded(state)
  const designerStats = getDesignerStats(state)

  return {
    loaded,
    total: getAvailableForPayout(state),
    resultStats: getResultStats(designerStats)
  }
}

const mapDispatchToProps = {
  onDesignerStatsReceived: DesignerStatsUpdated,
  loadDesignerStats
}

export default connect(mapStateToProps, mapDispatchToProps)(DesignerStatsPanelContainer)
