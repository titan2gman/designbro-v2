export const getDesignerNdas = (state) => (
  state.designerNdas.ids.map((id) =>
    state.entities.designerNdas[id]
  )
)
