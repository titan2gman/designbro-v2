import moment from 'moment'

const getTimeLeft = (stageExpiresAt) => {
  if (!stageExpiresAt) {
    return pastTimeDifference
  }

  return getTimeDiffInDaysOrHours(stageExpiresAt)
}

export const pastTimeDifference = '0 hours'

export const getTimeDiffInDaysOrHours = (to, from = new Date()) => {
  const diffInHours = moment(to).diff(from, 'hours')

  if (diffInHours < 0) {
    return pastTimeDifference
  }

  let suffix
  const isLessThanOneDay = diffInHours < 24
  const diff = moment(to).diff(from, isLessThanOneDay ? 'hours' : 'days')

  if (isLessThanOneDay) {
    suffix = diff === 1 ? 'hour' : 'hours'
  } else {
    suffix = diff === 1 ? 'day' : 'days'
  }

  return `${diff} ${suffix}`
}

export const getStateTime = (project) => {
  switch (project.state) {
  case 'design_stage':
    return getTimeLeft(project.designStageExpiresAt)
  case 'finalist_stage':
    return getTimeLeft(project.finalistStageExpiresAt)
  case 'files_stage':
    return getTimeLeft(project.filesStageExpiresAt)
  case 'review_files':
    return getTimeLeft(project.reviewFilesStageExpiresAt)
  default:
    return pastTimeDifference
  }
}

export const getAgeInDays = (createdAt) =>
  `${moment().diff(new Date(createdAt), 'days')} ${moment().diff(new Date(createdAt), 'days') > 1 ? 'days' : 'day'}`

export const isGreaterInHoursThan = (a, b) =>
  moment(a).diff(moment(), 'hours') >= b
