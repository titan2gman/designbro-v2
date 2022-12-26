import bugsnag from '@bugsnag/js'

export const bugsnagClient = bugsnag({
  apiKey: process.env.BUGSNAG_JAVASCRIPT_API_KEY,
  notifyReleaseStages: ['staging', 'production']
})
