export const getProjectBuilderPath = (project) => {
  switch (project.state) {
  case 'draft':
    return project.productKey === 'logo2' ? `/new-project/${project.id}/${project.currentStepPath}` : `/projects/${project.id}/${project.currentStepPath}`
  case 'design_stage':
  case 'finalist_stage':
  case 'files_stage':
  case 'review_files':
  case 'completed':
  case 'canceled':
  case 'error':
    return `/c/projects/${project.id}`
  default:
    return '/c'
  }
}
