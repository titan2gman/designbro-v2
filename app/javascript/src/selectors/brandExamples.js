import _ from 'lodash'

export const areBrandExamplesInProgress = (state) => state.brandExamples.inProgress
export const getBrandExamples = (state) => _.map(state.brandExamples.ids, (id) => state.entities.brandExamples[id])
