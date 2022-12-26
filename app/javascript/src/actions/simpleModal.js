export const open = ({ title, message }) => ({
  type: 'SIMPLE_MODAL_OPEN',
  title,
  message
})

export const close = () => ({
  type: 'SIMPLE_MODAL_CLOSE'
})
