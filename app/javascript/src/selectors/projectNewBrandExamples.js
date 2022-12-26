export const getProjectNewBrandExamples = (state) =>
  state.projectNewBrandExamples.ids.map(id => state.entities.newBrandExamples[id])
