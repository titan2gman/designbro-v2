export const getProjectBrandExamples = (state) => state.projectBrandExamples.ids.map((id) =>
  state.entities.projectBrandExamples[id]
)

export const getBadExamples = (state) => getProjectBrandExamples(state).filter((example) =>
  example.exampleType === 'bad'
)

export const getGoodExamples = (state) => getProjectBrandExamples(state).filter((example) =>
  example.exampleType === 'good'
)
