const initialState = { open: false }

const reducer = (state = initialState, action) => {
  switch (action.type) {
  case 'SIMPLE_MODAL_OPEN':
    return { open: true, title: action.title, message: action.message }
  case 'SIMPLE_MODAL_CLOSE':
    return { open: false }
  default:
    return state
  }
}

export default reducer
