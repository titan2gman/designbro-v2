import React from 'react'

const getProjectName = () => {
  const URLSearchParams = window.URLSearchParams
  const paramsString = document.location.search
  const params = new URLSearchParams(paramsString)
  return params.get('projectName')
}

export default () => (
  <main>
    <div className="error-page container text-center">
      <p className="error-page__text">
        We will no longer send you emails to start your project: {getProjectName()}.
      </p>
    </div>
  </main>
)
