import api from '@utils/api'
import { getFileData } from '@utils/fileUtilities'

export const selectVersion = (value) => ({
  type: 'SELECT_DESIGN_VERSION',
  value
})

export const restoreVersion = (projectId, designId, value) => {
  if (!value) {
    return { type: 'NOOP' }
  }
  return api.patch({
    endpoint: `/api/v1/projects/${projectId}/designs/${designId}/restore`,
    body: { versionId: value },
    types: ['RESTORE_VERSION_REQUEST', 'RESTORE_VERSION_SUCCESS', 'RESTORE_VERSION_FAILURE'],
    normalize: true
  })
}

export const uploadVersion = (projectId, designId, file) =>
  api.patch({
    endpoint: `/api/v1/projects/${projectId}/designs/${designId}`,
    types: [
      'VERSION_UPLOAD_REQUEST',
      'VERSION_UPLOAD_SUCCESS',
      'VERSION_UPLOAD_FAILURE'
    ],
    body: getFileData({ file }),
    normalize: true
  })
