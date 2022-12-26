export const isPaymentNeeded = (project) => {
  return project.state === 'draft'
}

export const isInProgress = (project) => {
  return [
    'design_stage',
    'finalist_stage',
    'files_stage',
    'review_files'
  ].includes(project.state)
}

export const isCompleted = (project) => {
  return project.state === 'completed'
}

export const isBriefingNeeded = (project) => {
  return project.state === 'waiting_for_stationery_details' || (project.state === 'draft' && project.projectType === 'one_to_one')
}

export const getProjectStateGroup = (project) => {
  if (isInProgress(project)) {
    return 'In progress'
  }

  if (isBriefingNeeded(project)) {
    return 'Briefing details needed'
  }

  if (isPaymentNeeded(project)) {
    return 'Payment needed'
  }

  if (isBriefingNeeded(project)) {
    return 'Briefing details needed'
  }

  if (isCompleted(project)) {
    return 'Completed'
  }

  return 'Other'
}
