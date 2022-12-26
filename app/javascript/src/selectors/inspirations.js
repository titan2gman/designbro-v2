export const getInspirations = (state) => state.inspirations.ids.map((id) =>
  state.entities.inspirations[id]
)
