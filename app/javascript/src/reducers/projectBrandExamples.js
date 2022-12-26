import { combineReducers } from 'redux'

const ids = (state = [], action) => {
  switch (action.type) {
  case 'PROJECT_LOAD_SUCCESS':
    return action.payload.results.projectBrandExamples || []
  default:
    return state
  }
}

export default combineReducers({
  ids
})

const getProjectBrandExamples = (state) =>
  state.projectBrandExamples.ids.map((id) =>
    state.entities.projectBrandExamples[id]
  )

const getBadExamples = (state) =>
  getProjectBrandExamples(state).filter((example) => example.exampleType === 'bad')

const getGoodExamples = (state) =>
  getProjectBrandExamples(state).filter((example) => example.exampleType === 'good')

export { getProjectBrandExamples, getBadExamples, getGoodExamples }
