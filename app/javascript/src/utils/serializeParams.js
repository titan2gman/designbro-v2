export default object => Object.keys(object).map(
  key => key + '=' + object[key]
).join('&')
