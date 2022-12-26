import api from '@utils/api'
import { getFileData } from '@utils/fileUtilities'

export const upload = (id, file) => api.post({
  endpoint: `/api/v1/projects/${id}/project_source_files`,
  types: [
    'SOURCE_FILE_UPLOAD_REQUEST',
    'SOURCE_FILE_UPLOAD_SUCCESS',
    'SOURCE_FILE_UPLOAD_FAILURE'
  ],
  body: getFileData({ file: file, type: 'source_file' }),
  normalize: true
})

export const loadSourceFiles = (id) => api.get({
  endpoint: `/api/v1/projects/${id}/project_source_files`,
  types: [
    'SOURCE_FILES_LOAD_REQUEST',
    'SOURCE_FILES_LOAD_SUCCESS',
    'SOURCE_FILES_LOAD_FAILURE'
  ],
  normalize: true
})

export const deleteSourceFile = (projectId, fileId) => api.delete({
  endpoint: `/api/v1/projects/${projectId}/project_source_files/${fileId}`,
  types: [
    'SOURCE_FILE_DELETE_REQUEST',
    'SOURCE_FILE_DELETE_SUCCESS',
    'SOURCE_FILE_DELETE_FAILURE'
  ],
  normalize: true
})


export const destroySourceFile = (projectId, fileId) => (dispatch) => {
  dispatch(deleteSourceFile(projectId, fileId)).then(() => {
    dispatch({ type: 'DESTROY_SOURCE_FILE', id: fileId })
  })
}

