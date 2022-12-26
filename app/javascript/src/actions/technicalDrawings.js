import api from '@utils/api'

import { getFileData } from '@utils/fileUtilities'

const uploadTechnicalDrawing = (file) => api.post({
  endpoint: '/api/v1/public/technical_drawings',
  body: getFileData({ file }),

  types: [
    'TECHNICAL_DRAWING_UPLOAD_REQUEST',
    'TECHNICAL_DRAWING_UPLOAD_SUCCESS',
    'TECHNICAL_DRAWING_UPLOAD_FAILURE'
  ]
})

export { uploadTechnicalDrawing }
