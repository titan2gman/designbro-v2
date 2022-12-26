import api from '@utils/api'

import { getFileData } from '@utils/fileUtilities'

export const loadDesign = (projectId, designId) => api.get({
  endpoint: `/api/v1/projects/${projectId}/designs/${designId}`,
  normalize: true,

  types: [
    'LOAD_DESIGN_REQUEST',
    'LOAD_DESIGN_SUCCESS',
    'LOAD_DESIGN_FAILURE'
  ]
})

export const loadVersions = (projectId, designId) => api.get({
  endpoint: `/api/v1/projects/${projectId}/designs/${designId}/versions`,
  normalize: true,

  types: [
    'LOAD_DESIGN_VERSIONS_REQUEST',
    'LOAD_DESIGN_VERSIONS_SUCCESS',
    'LOAD_DESIGN_VERSIONS_FAILURE'
  ]
})

export const changeViewMode = (value) => ({
  type: 'CHANGE_VIEW_MODE',
  value
})

export const closeChat = () => ({
  type: 'CLOSE_DIRECT_CONVERSATION_CHAT'
})

export const selectWinner = (designId) => api.post({
  endpoint: '/api/v1/winners',
  body: { designId },
  normalize: true,

  types: [
    'SELECT_WINNER_REQUEST',
    'SELECT_WINNER_SUCCESS',
    'SELECT_WINNER_FAILURE'
  ]
})

// seems not needed, we load all designs along with project
export const loadMyDesigns = (projectId) =>
  api.get({
    endpoint: `/api/v1/projects/${projectId}/designs`,
    types: [
      'MY_DESIGNS_LOAD_REQUEST',
      'MY_DESIGNS_LOAD_SUCCESS',
      'MY_DESIGNS_LOAD_FAILURE'
    ],
    normalize: true
  })

export const rateDesign = (projectId, designId, value) =>
  api.patch({
    endpoint: `/api/v1/projects/${projectId}/designs/${designId}`,
    body: { design: { rating: value } },
    types: ['RATE_DESIGN_REQUEST', 'RATE_DESIGN_SUCCESS', 'RATE_DESIGN_FAILURE'],
    normalize: true
  })

export const selectFinalist = (projectId, designId) =>
  api.patch({
    endpoint: `/api/v1/projects/${projectId}/designs/${designId}`,
    body: { design: { finalist: true } },
    types: ['SELECT_FINALIST_REQUEST', 'SELECT_FINALIST_SUCCESS', 'SELECT_FINALIST_FAILURE'],
    normalize: true
  })

export const approveStationery = (projectId, designId) =>
  api.patch({
    endpoint: `/api/v1/projects/${projectId}/designs/${designId}`,
    body: { design: { stationery_approved: true } },
    types: [
      'APPROVE_STATIONERY_REQUEST',
      'APPROVE_STATIONERY_SUCCESS',
      'APPROVE_STATIONERY_FAILURE'
    ],
    normalize: true
  })

export const eliminateDesign = (projectId, designId, eliminationData) => {
  // debugger
  return api.patch({
    // WTF? route refactoring? do we need project for eliminating???
    endpoint: `/api/v1/projects/${projectId}/designs/${designId}/eliminate?include[]=project&include[]=spot`,
    normalize: true,
    body: { design: eliminationData },
    types: [
      'ELIMINATE_DESIGN_REQUEST',
      'ELIMINATE_DESIGN_SUCCESS',
      'ELIMINATE_DESIGN_FAILURE'
    ]
  })
}

const pureBlockDesigner = (projectId, designId, blockData) => (
  api.patch({
    endpoint: `/api/v1/projects/${projectId}/designs/${designId}/block`,
    normalize: true,
    body: { design: blockData },
    types: [
      'BLOCK_DESIGNER_REQUEST',
      'BLOCK_DESIGNER_SUCCESS',
      'BLOCK_DESIGNER_FAILURE'
    ]
  })
)

export const REMOVE_BLOCKED_DESIGN = 'REMOVE_BLOCKED_DESIGN'

const removeBlockedDeisngs = (spotId) => ({
  type: REMOVE_BLOCKED_DESIGN,
  spotId
})

export const blockDesigner = (projectId, designId, blockData) => (dispatch, getState) => {
  const state = getState()
  const spotId = state.entities.designs[designId].spot

  dispatch(removeBlockedDeisngs(spotId))

  return dispatch(pureBlockDesigner(projectId, designId, blockData))
}

export const upload = (id, file) =>
  api.post({
    endpoint: `/api/v1/projects/${id}/designs`,
    types: [
      'DESIGN_FILE_UPLOAD_REQUEST',
      'DESIGN_FILE_UPLOAD_SUCCESS',
      'DESIGN_FILE_UPLOAD_FAILURE'
    ],
    body: getFileData({ file }),
    normalize: true
  })

export const uploadDesign = (file, projectId, callback ) => (dispatch) => {
  if (!file) return

  if (file.type !== 'image/jpeg' && file.type !== 'image/png') {
    window.alert('Wrong file format! Only JPG or PNG!')
    return
  }

  if (file.size > 2 * 1024 * 1024) {
    window.alert('File is too big! 2MB or less!')
    return
  }

  dispatch(upload(projectId, file)).then((action, error) => {
    if (!error) {
      callback && callback(action)
    }
  })
}
