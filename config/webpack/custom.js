const path = require('path')

module.exports = {
  resolve: {
    alias: {
      '@actions': path.resolve(__dirname, '..', '..', 'app/javascript/src/actions'),
      '@client': path.resolve(__dirname, '..', '..', 'app/javascript/src/client'),
      '@components': path.resolve(__dirname, '..', '..', 'app/javascript/src/components'),
      '@constants': path.resolve(__dirname, '..', '..', 'app/javascript/src/constants'),
      '@containers': path.resolve(__dirname, '..', '..', 'app/javascript/src/containers'),
      '@designer': path.resolve(__dirname, '..', '..', 'app/javascript/src/designer'),
      '@login': path.resolve(__dirname, '..', '..', 'app/javascript/src/login'),
      '@modals': path.resolve(__dirname, '..', '..', 'app/javascript/src/modals'),
      '@ndas': path.resolve(__dirname, '..', '..', 'app/javascript/src/ndas'),
      '@password': path.resolve(__dirname, '..', '..', 'app/javascript/src/password'),
      '@project': path.resolve(__dirname, '..', '..', 'app/javascript/src/project'),
      '@projects': path.resolve(__dirname, '..', '..', 'app/javascript/src/projects'),
      '@reducers': path.resolve(__dirname, '..', '..', 'app/javascript/src/reducers'),
      '@selectors': path.resolve(__dirname, '..', '..', 'app/javascript/src/selectors'),
      '@settings': path.resolve(__dirname, '..', '..', 'app/javascript/src/settings'),
      '@signup': path.resolve(__dirname, '..', '..', 'app/javascript/src/signup'),
      '@static': path.resolve(__dirname, '..', '..', 'app/javascript/src/static'),
      '@store': path.resolve(__dirname, '..', '..', 'app/javascript/src/store'),
      '@utils': path.resolve(__dirname, '..', '..', 'app/javascript/src/utils')
    }
  }
}
