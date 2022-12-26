const { environment } = require('@rails/webpacker')
const webpack = require('webpack')
const dotenv = require('dotenv')
const customConfig = require('./custom')

const dotenvFiles = [
  `.env.${process.env.NODE_ENV}.local`,
  '.env.local',
  `.env.${process.env.NODE_ENV}`,
  '.env'
]
dotenvFiles.forEach((dotenvFile) => {
  dotenv.config({ path: dotenvFile, silent: true })
})

environment.plugins.prepend('Environment', new webpack.EnvironmentPlugin(JSON.parse(JSON.stringify(process.env))))

environment.config.merge(customConfig)

const babelLoader = environment.loaders.get('babel')

environment.loaders.insert('svg', {
  test: /\.newsvg$/,
  use: babelLoader.use.concat([
    {
      loader: 'react-svg-loader',
      options: {
        jsx: true // true outputs JSX tags
      }
    }
  ])
}, { before: 'file' })

const fileLoader = environment.loaders.get('file')
fileLoader.exclude = /\.(newsvg)$/i

environment.loaders.delete('nodeModules')

environment.splitChunks()

module.exports = environment
