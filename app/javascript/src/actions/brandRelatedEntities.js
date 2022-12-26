// actions for uploading and deleting
// existing designs, competitors and inspirations
// and project additional documents (brandId is optional)

import snakeCase from 'lodash/snakeCase'
import api from '@utils/api'
import { getFileData } from '@utils/fileUtilities'

export const EXISTING_DESIGN_UPLOAD_REQUEST = 'EXISTING_DESIGN_UPLOAD_REQUEST'
export const EXISTING_DESIGN_UPLOAD_SUCCESS = 'EXISTING_DESIGN_UPLOAD_SUCCESS'
export const EXISTING_DESIGN_UPLOAD_FAILURE = 'EXISTING_DESIGN_UPLOAD_FAILURE'

export const COMPETITOR_UPLOAD_REQUEST = 'COMPETITOR_UPLOAD_REQUEST'
export const COMPETITOR_UPLOAD_SUCCESS = 'COMPETITOR_UPLOAD_SUCCESS'
export const COMPETITOR_UPLOAD_FAILURE = 'COMPETITOR_UPLOAD_FAILURE'

export const INSPIRATION_UPLOAD_REQUEST = 'INSPIRATION_UPLOAD_REQUEST'
export const INSPIRATION_UPLOAD_SUCCESS = 'INSPIRATION_UPLOAD_SUCCESS'
export const INSPIRATION_UPLOAD_FAILURE = 'INSPIRATION_UPLOAD_FAILURE'

export const STOCK_IMAGE_UPLOAD_REQUEST = 'STOCK_IMAGE_UPLOAD_REQUEST'
export const STOCK_IMAGE_UPLOAD_SUCCESS = 'STOCK_IMAGE_UPLOAD_SUCCESS'
export const STOCK_IMAGE_UPLOAD_FAILURE = 'STOCK_IMAGE_UPLOAD_FAILURE'

export const ADDITIONAL_DOCUMENT_UPLOAD_REQUEST = 'ADDITIONAL_DOCUMENT_UPLOAD_REQUEST'
export const ADDITIONAL_DOCUMENT_UPLOAD_SUCCESS = 'ADDITIONAL_DOCUMENT_UPLOAD_SUCCESS'
export const ADDITIONAL_DOCUMENT_UPLOAD_FAILURE = 'ADDITIONAL_DOCUMENT_UPLOAD_FAILURE'

export const EXISTING_DESIGN_DESTROY_REQUEST = 'EXISTING_DESIGN_DESTROY_REQUEST'
export const EXISTING_DESIGN_DESTROY_SUCCESS = 'EXISTING_DESIGN_DESTROY_SUCCESS'
export const EXISTING_DESIGN_DESTROY_FAILURE = 'EXISTING_DESIGN_DESTROY_FAILURE'

export const COMPETITOR_DESTROY_REQUEST = 'COMPETITOR_DESTROY_REQUEST'
export const COMPETITOR_DESTROY_SUCCESS = 'COMPETITOR_DESTROY_SUCCESS'
export const COMPETITOR_DESTROY_FAILURE = 'COMPETITOR_DESTROY_FAILURE'

export const INSPIRATION_DESTROY_REQUEST = 'INSPIRATION_DESTROY_REQUEST'
export const INSPIRATION_DESTROY_SUCCESS = 'INSPIRATION_DESTROY_SUCCESS'
export const INSPIRATION_DESTROY_FAILURE = 'INSPIRATION_DESTROY_FAILURE'

export const STOCK_IMAGE_DESTROY_REQUEST = 'STOCK_IMAGE_DESTROY_REQUEST'
export const STOCK_IMAGE_DESTROY_SUCCESS = 'STOCK_IMAGE_DESTROY_SUCCESS'
export const STOCK_IMAGE_DESTROY_FAILURE = 'STOCK_IMAGE_DESTROY_FAILURE'

export const ADDITIONAL_DOCUMENT_DESTROY_REQUEST = 'ADDITIONAL_DOCUMENT_DESTROY_REQUEST'
export const ADDITIONAL_DOCUMENT_DESTROY_SUCCESS = 'ADDITIONAL_DOCUMENT_DESTROY_SUCCESS'
export const ADDITIONAL_DOCUMENT_DESTROY_FAILURE = 'ADDITIONAL_DOCUMENT_DESTROY_FAILURE'

export const CHANGE_BRAND_RELATED_ENTITY_IN_THE_LIST = 'CHANGE_BRAND_RELATED_ENTITY_IN_THE_LIST'
export const REMOVE_BRAND_RELATED_ENTITY_FROM_THE_LIST = 'REMOVE_BRAND_RELATED_ENTITY_FROM_THE_LIST'

const uploadActionTypeNames = {
  existingDesigns: [
    EXISTING_DESIGN_UPLOAD_REQUEST, EXISTING_DESIGN_UPLOAD_SUCCESS, EXISTING_DESIGN_UPLOAD_FAILURE
  ],
  competitors: [
    COMPETITOR_UPLOAD_REQUEST, COMPETITOR_UPLOAD_SUCCESS, COMPETITOR_UPLOAD_FAILURE
  ],
  inspirations: [
    INSPIRATION_UPLOAD_REQUEST, INSPIRATION_UPLOAD_SUCCESS, INSPIRATION_UPLOAD_FAILURE
  ],
  projectAdditionalDocuments: [
    ADDITIONAL_DOCUMENT_UPLOAD_REQUEST, ADDITIONAL_DOCUMENT_UPLOAD_SUCCESS, ADDITIONAL_DOCUMENT_UPLOAD_FAILURE
  ],
  projectStockImages: [
    STOCK_IMAGE_UPLOAD_REQUEST, STOCK_IMAGE_UPLOAD_SUCCESS, STOCK_IMAGE_UPLOAD_FAILURE
  ]
}

const destroyActionTypeNames = {
  existingDesigns: [
    EXISTING_DESIGN_DESTROY_REQUEST, EXISTING_DESIGN_DESTROY_SUCCESS, EXISTING_DESIGN_DESTROY_FAILURE
  ],
  competitors: [
    COMPETITOR_DESTROY_REQUEST, COMPETITOR_DESTROY_SUCCESS, COMPETITOR_DESTROY_FAILURE
  ],
  inspirations: [
    INSPIRATION_DESTROY_REQUEST, INSPIRATION_DESTROY_SUCCESS, INSPIRATION_DESTROY_FAILURE
  ],
  projectAdditionalDocuments: [
    ADDITIONAL_DOCUMENT_DESTROY_REQUEST, ADDITIONAL_DOCUMENT_DESTROY_SUCCESS, ADDITIONAL_DOCUMENT_DESTROY_FAILURE
  ],
  projectStockImages: [
    STOCK_IMAGE_DESTROY_REQUEST, STOCK_IMAGE_DESTROY_SUCCESS, STOCK_IMAGE_DESTROY_FAILURE
  ]
}

const buildUrl = (entityName, id, isBrand) => {
  if (isBrand) {
    return `/api/v1/public/brands/${id}/${snakeCase(entityName)}`
  }

  return `/api/v1/public/projects/${id}/${snakeCase(entityName)}`
}

const uploadEntity = (entityName, relationId, file, isBrand = true) => api.post({
  endpoint: buildUrl(entityName, relationId, isBrand),
  body: getFileData({ file }),

  types: uploadActionTypeNames[entityName]
})

const destroyEntity = (entityName, relationId, id, isBrand = true) => api.delete({
  endpoint: `${buildUrl(entityName, relationId, isBrand)}/${id}`,

  types: destroyActionTypeNames[entityName]
})

export const changeEntityAttribute = (entityName, index, name, value) => ({
  type: CHANGE_BRAND_RELATED_ENTITY_IN_THE_LIST,
  payload: {
    entityName,
    index: parseInt(index, 10),
    name,
    value
  }
})

const removeEntityFromTheList = (entityName, index) => ({
  type: REMOVE_BRAND_RELATED_ENTITY_FROM_THE_LIST,
  payload: {
    entityName,
    index: parseInt(index, 10)
  }
})

const getIsBrand = (entityName) => {
  return ['competitors'].includes(entityName)
}

const getRelatedId = (state, entityName) => {
  const projectId = state.projects.current

  if (getIsBrand(entityName)) {
    return state.entities.projects[projectId].brand
  }

  return projectId
}

export const upload = (entityName, index, previousUploadedFileId) => (dispatch, getState) => (file) => {
  const isBrand = getIsBrand(entityName)
  const relatedId = getRelatedId(getState(), entityName)

  if (previousUploadedFileId) {
    dispatch(destroyEntity(entityName, relatedId, previousUploadedFileId, isBrand))
  }

  dispatch(uploadEntity(entityName, relatedId, file, isBrand)).then((response) => {
    if (response.error) {
      window.alert(response.payload.response.errors.file.join('\n'))
    } else {
      dispatch(changeEntityAttribute(entityName, index, 'uploadedFileId', response.payload.data.id))
    }
  })

  dispatch(changeEntityAttribute(entityName, index, 'previewUrl', file.preview))
}

export const destroy = (entityName, index, uploadedFileId) => (dispatch, getState) => () => {
  const isBrand = getIsBrand(entityName)
  const relatedId = getRelatedId(getState(), entityName)

  dispatch(destroyEntity(entityName, relatedId, uploadedFileId, isBrand))
  dispatch(removeEntityFromTheList(entityName, index))
}
