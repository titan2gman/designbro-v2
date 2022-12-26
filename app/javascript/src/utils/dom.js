import merge from 'lodash/merge'

export const appendScript = (props) => {
  const script = document.createElement('script')

  merge(script, props)

  document.body.appendChild(script)
}
