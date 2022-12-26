import isObject from 'lodash/isObject'
import isArray from 'lodash/isArray'
import reduce from 'lodash/reduce'
import groupBy from 'lodash/groupBy'
import mapValues from 'lodash/mapValues'

function camelizeString (str) {
  return str.replace(/-(.)/g, (match, group) => group.toUpperCase())
}

function camelizeKeys (object) {
  const camelizeObject = {}
  Object.keys(object).forEach((key) => (
    camelizeObject[camelizeString(key)] = object[key]
  ))
  return camelizeObject
}

export function normalizeEntity (entity) {
  const normalized = {
    id: entity.id,
    type: entity.type
  }

  Object.keys(entity.attributes || []).forEach((key) => {
    normalized[key] = entity.attributes[key]
  })

  Object.keys(entity.relationships || []).forEach((key) => {
    const value = entity.relationships[key]
    if (isArray(value.data)) {
      normalized[key] = value.data.map((item) => item.id)
    } else if (isObject(value.data)) {
      normalized[key] = value.data.id
    }
  })

  return normalized
}

function normalizeResponse ({ meta, data, included }) {
  let entities = []
    .concat((isArray(data) ? data : [data]).map(normalizeEntity))
    .concat((included || []).map(normalizeEntity))

  entities = groupBy(entities, (value) => value.type)
  entities = mapValues(entities, (value) =>
    reduce(value, (result, resultValue) => {
      const formatResult = result
      formatResult[resultValue.id] = camelizeKeys(resultValue)
      return formatResult
    }, {})
  )

  // Preserving order
  let objects = [].concat(isArray(data) ? data : [data]).concat(included || [])
  objects = groupBy(objects, (value) => value.type)
  const results = mapValues(objects, (vals) => vals.map((v) => v.id))

  return { results, entities, meta }
}

export default function (obj) {
  // throw new Error('Normalize JSON API accepts an object as its input.')
  return isObject(obj) ? normalizeResponse(obj) : {}
}

export const applyNormalize = (callback) =>
  ({ data }) => callback(normalizeEntity(data))
