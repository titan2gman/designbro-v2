import _ from 'lodash'

export const getNdaById = (id) => (state) => {
  return _.get(state.entities.ndas, id)
}
