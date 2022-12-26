import api from '@utils/api'
import { getFileData } from '@utils/fileUtilities'

export const FEATURED_IMAGE_UPLOAD_REQUEST = 'FEATURED_IMAGE_UPLOAD_REQUEST'
export const FEATURED_IMAGE_UPLOAD_SUCCESS = 'FEATURED_IMAGE_UPLOAD_SUCCESS'
export const FEATURED_IMAGE_UPLOAD_FAILURE = 'FEATURED_IMAGE_UPLOAD_FAILURE'

export const FEATURED_IMAGE_DESTROY_REQUEST = 'FEATURED_IMAGE_DESTROY_REQUEST'
export const FEATURED_IMAGE_DESTROY_SUCCESS = 'FEATURED_IMAGE_DESTROY_SUCCESS'
export const FEATURED_IMAGE_DESTROY_FAILURE = 'FEATURED_IMAGE_DESTROY_FAILURE'

const buildUrl = (id) => {
  return `/api/v1/projects/${id}/featured_images`
}

const uploadImage = (projectId, file) => api.post({
  endpoint: buildUrl(projectId),
  body: getFileData({ file }),

  types: [FEATURED_IMAGE_UPLOAD_REQUEST, FEATURED_IMAGE_UPLOAD_SUCCESS, FEATURED_IMAGE_UPLOAD_FAILURE]
})

const destroyImage = (projectId, id) => api.delete({
  endpoint: `${buildUrl(projectId)}/${id}`,

  types: [FEATURED_IMAGE_DESTROY_REQUEST, FEATURED_IMAGE_DESTROY_SUCCESS, FEATURED_IMAGE_DESTROY_FAILURE]
})

export const upload = (previousUploadedFileId) => (dispatch, getState) => (file) => {
  const state = getState()
  const projectId = state.projects.current

  if (previousUploadedFileId) {
    dispatch(destroyImage(projectId, previousUploadedFileId))
  }

  dispatch(uploadImage(projectId, file)).then((response) => {
    if (response.error) {
      window.alert(response.payload.response.errors.file.join('\n'))
    }
  })
}

export const destroy = (uploadedFileId) => (dispatch, getState) => () => {
  const state = getState()
  const projectId = state.projects.current

  dispatch(destroyImage(projectId, uploadedFileId))
}
