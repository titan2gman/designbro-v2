export const getCompetitors = (state) => state.competitors.ids.map((id) =>
  state.entities.competitors[id]
)
