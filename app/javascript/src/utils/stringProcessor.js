import filter from 'lodash/filter'
import truncate from 'lodash/truncate'

const splitStringBySpace = (string) => (
  filter(string.split(' '), (word) => !!word)
)

const cutAt = (string, length) => truncate(
  string, { separator: /,? +/, length }
)

export { splitStringBySpace, cutAt }
