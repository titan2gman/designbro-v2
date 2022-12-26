export const normalizeState = (state) => {
  switch (state) {
  case 'finalist':
  case 'stationery':
  case 'stationery_uploaded':
    return 'finalist'

  case 'winner':
    return 'winner'

  default:
    return null
  }
}
