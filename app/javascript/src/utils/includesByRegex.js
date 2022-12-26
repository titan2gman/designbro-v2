import some from 'lodash/some'
import includes from 'lodash/includes'

export default (urls, pathname) => !some(urls, (url) => includes(pathname, url))
