const getFileData = (data) => {
  const formData = new window.FormData()
  formData.append('file', data.file)
  formData.append('type', data.type)
  return formData
}

const getMultipleFileData = (data) => {
  const formData = new window.FormData()
  data.files.forEach(file => formData.append('fileToUpload[]', file))
  formData.append('text', data.text)
  return formData
}

export { getFileData, getMultipleFileData }
