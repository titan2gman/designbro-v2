import api from '@utils/api'

export const loadDesignerStats = () => api.get({
  endpoint: '/api/v1/designer_stats',
  normalize: true,

  types: [
    'DESIGNER_STATS_LOAD_REQUEST',
    'DESIGNER_STATS_LOAD_SUCCESS',
    'DESIGNER_STATS_LOAD_FAILURE'
  ]
})

export const DesignerStatsUpdated = (designerStats) => ({
  type: 'DESIGNER_STATS_UPDATED', designerStats
})
