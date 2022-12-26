export const debounce = (fn, delay) => {
  let timeoutId
  return function(...args) {
    clearInterval(timeoutId)
    timeoutId = setTimeout(() => fn.apply(this, args), delay)
  }
}
