export const letterifyName = (parts) => {
  return parts && parts.length
    ? parts.map((w) => w && w[0]).join('').substring(0, 2).toUpperCase()
    : 'U'
}
